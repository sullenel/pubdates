import 'dart:io';

import 'package:pubdates/features/project/models/package_update.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubdates/features/project/services/pubspec_service.dart';

mixin ProjectRepository {
  Future<Project> getProject(Directory path);

  Stream<PackageUpdate> getPackageUpdates(Directory path);
}

class DefaultProjectRepository implements ProjectRepository {
  const DefaultProjectRepository({
    required PubspecService pubspecService,
  }) : _pubspecService = pubspecService;

  final PubspecService _pubspecService;

  @override
  Stream<PackageUpdate> getPackageUpdates(Directory path) {
    // TODO: implement getPackageUpdates
    throw UnimplementedError();
  }

  @override
  Future<Project> getProject(Directory path) {
    return _pubspecService.readProject(path);
  }
}
