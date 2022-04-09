import 'dart:io';

import 'package:path/path.dart';
import 'package:pubdates/common/persistence/key_value_store.dart';
import 'package:pubdates/common/utils/iterable_utils.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/common/utils/typedefs.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';

// facepalm.jpg
Iterable<String> _generatePossibleIconLocations(String path) sync* {
  // Android
  yield join(
    path,
    'android',
    'app',
    'src',
    'main',
    'res',
    'mipmap-mdpi',
    'ic_launcher.png',
  );

  // iOS
  yield join(
    path,
    'ios',
    'Runner',
    'Assets.xcassets',
    'AppIcon.appiconset',
    'Icon-App-40x40@3x.png',
  );

  // macOS
  yield join(
    path,
    'macos',
    'Runner',
    'Assets.xcassets',
    'AppIcon.appiconset',
    'app_icon_64.png',
  );
}

class OpenProjectsRepository {
  static const _projectsKey = 'opened_projects';

  const OpenProjectsRepository({
    required int maxSavedCount,
    required KeyValueStore storage,
  })  : _maxCount = maxSavedCount,
        _storage = storage;

  final int _maxCount;
  final KeyValueStore _storage;

  Future<List<String>> get _openedProjectPaths async {
    return await _storage.getStrings(_projectsKey) ?? const <String>[];
  }

  Future<void> _save(List<String> projects) {
    return _storage.putStrings(_projectsKey, projects);
  }

  Future<void> _removeInBatch(Set<String> projects) async {
    final savedPaths = await _openedProjectPaths;
    final finalProjects =
        savedPaths.where((it) => !projects.contains(it)).toFixedList();
    return _save(finalProjects);
  }

  Future<String?> _findProjectIcon(String path) async {
    for (final iconPath in _generatePossibleIconLocations(path)) {
      // Regarding async I/O methods: https://github.com/dart-lang/sdk/issues/36269
      if (await File(iconPath).exists()) {
        return iconPath;
      }
    }

    return null;
  }

  Future<OpenedProjectEntry> _createProject(Directory path) async {
    final iconPath = await _findProjectIcon(path.fullPath);
    return OpenedProjectEntry(path: path, iconPath: iconPath);
  }

  Stream<OpenedProjectEntry> allProjects() {
    return _openedProjectPaths
        .asStream()
        .expand(identity)
        .map<Directory>(Directory.new)
        .asyncMap(_createProject);
  }

  Stream<OpenedProjectEntry> allActiveProjects() async* {
    final toBeRemoved = <String>{};

    await for (final project in allProjects()) {
      if (await project.exists()) {
        yield project;
      } else {
        toBeRemoved.add(project.fullPath);
      }
    }

    if (toBeRemoved.isNotEmpty) {
      await _removeInBatch(toBeRemoved);
    }
  }

  Future<void> add(Directory path) async {
    final savedPaths = await _openedProjectPaths;
    final newPath = path.fullPath;
    final isAdded = savedPaths.any((it) => it == newPath);

    assert(!isAdded, 'Cannot add a project that is already saved');
    if (!isAdded) {
      final projects = [newPath, ...savedPaths].takeFromStart(_maxCount);
      return _save(projects);
    }
  }

  Future<void> remove(Directory path) async {
    final savedPaths = await _openedProjectPaths;
    final projectPath = path.fullPath;
    final isSaved = savedPaths.any((it) => it == projectPath);

    if (isSaved) {
      final projects =
          savedPaths.where((it) => it != projectPath).toFixedList();
      return _save(projects);
    }
  }

  Future<void> clear() {
    return _storage.delete(_projectsKey);
  }
}
