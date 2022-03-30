import 'dart:io';

import 'package:pubdates/common/persistence/key_value_store.dart';
import 'package:pubdates/common/utils/iterable_utils.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';

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

  Future<void> _removeInBatch(Set<String> projects) async {
    final savedPaths = await _openedProjectPaths;
    final finalProjects =
        savedPaths.where((it) => !projects.contains(it)).toList();
    return _storage.putStrings(_projectsKey, finalProjects);
  }

  Stream<OpenedProjectEntry> allProjects() async* {
    for (final it in await _openedProjectPaths) {
      final path = Directory(it);
      yield OpenedProjectEntry(path: path);
    }
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

  Future<void> add(OpenedProjectEntry project) async {
    final savedPaths = await _openedProjectPaths;
    final newPath = project.fullPath;
    final isAdded = savedPaths.any((it) => it == newPath);

    assert(!isAdded, 'Cannot add a project that is already saved');
    if (!isAdded) {
      final projects = [newPath, ...savedPaths].takeFromStart(_maxCount);
      return _storage.putStrings(_projectsKey, projects);
    }
  }

  Future<void> remove(OpenedProjectEntry project) async {
    final savedPaths = await _openedProjectPaths;
    final projectPath = project.fullPath;
    final projects = savedPaths.where((it) => it != projectPath).toList();
    return _storage.putStrings(_projectsKey, projects);
  }

  Future<void> clear() {
    return _storage.delete(_projectsKey);
  }
}
