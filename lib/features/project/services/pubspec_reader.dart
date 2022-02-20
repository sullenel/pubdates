import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubspec_lock/pubspec_lock.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

mixin PubspecReader {
  Future<void> checkValidProject(Directory path);

  Future<Project> readProject(Directory path);
}

class DefaultPubspecReader implements PubspecReader {
  const DefaultPubspecReader({
    String pubspecFileName = 'pubspec.yaml',
    String lockFileName = 'pubspec.lock',
  })  : _pubspecFileName = pubspecFileName,
        _lockFileName = lockFileName;

  final String _pubspecFileName;
  final String _lockFileName;

  @override
  Future<Project> readProject(Directory projectPath) async {
    final pubspec = await _readPubspecFile(projectPath);
    final pubspecLock = await _readLockFile(projectPath);

    return Project(
      name: pubspec.name,
      description: pubspec.description,
      dependencies: pubspecLock.dependencies,
      devDependencies: pubspecLock.devDependencies,
    );
  }

  Future<Pubspec> _readPubspecFile(Directory projectPath) async {
    final path = join(projectPath.absolute.path, _pubspecFileName);
    final file = File(path);
    final content = await file.readAsString();
    return Pubspec.parse(content);
  }

  Future<PubspecLock> _readLockFile(Directory projectPath) async {
    final path = join(projectPath.absolute.path, _lockFileName);
    final file = File(path);
    final content = await file.readAsString();
    return content.loadPubspecLockFromYaml();
  }

  @override
  Future<void> checkValidProject(Directory path) {
    // TODO: implement checkValidProject
    throw UnimplementedError();
  }
}

extension on HostedPackageDependency {
  Package toPackage() {
    return Package(name: name, version: version, url: url);
  }
}

extension on PubspecLock {
  List<Package> get dependencies =>
      hostedDependencies(DependencyType.direct).toList();

  List<Package> get devDependencies =>
      hostedDependencies(DependencyType.development).toList();

  Iterable<Package> hostedDependencies(DependencyType type) sync* {
    for (final pkg in packages) {
      // iswitcho my ass, could've easily named it qwertyuiop as well
      final mappedPkg = pkg.iswitcho(
        otherwise: () => null,
        hosted: (pkg) {
          if (pkg.type == type) {
            return pkg.toPackage();
          }
        },
      );

      if (mappedPkg != null) {
        yield mappedPkg;
      }
    }
  }
}
