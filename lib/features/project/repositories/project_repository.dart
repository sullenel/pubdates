import 'dart:io';

import 'package:pubdates/features/project/models/package_update.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubdates/features/project/services/pubspec_reader.dart';
import 'package:pubdates/features/project/services/package_service.dart';

mixin ProjectRepository {
  Future<Project> getProject(Directory path);

  Stream<PackageUpdate> getPackageUpdates(Directory path);
}

class DefaultProjectRepository implements ProjectRepository {
  const DefaultProjectRepository({
    required PubspecReader pubspecService,
    required PackageService packageUpdater,
  })  : _pubspecService = pubspecService,
        _packageUpdater = packageUpdater;

  final PubspecReader _pubspecService;
  final PackageService _packageUpdater;

  @override
  Stream<PackageUpdate> getPackageUpdates(Directory path) {
    return _packageUpdater.packagesToBeUpdated(path);
  }

  @override
  Future<Project> getProject(Directory path) {
    return _pubspecService.readProject(path);
  }
}
