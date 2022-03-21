import 'dart:convert';
import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/features/project/models/package_update.dart';

// Cannot come up with a good name for this as always
mixin PackageService {
  Stream<PackageUpdate> packagesToBeUpdated(Directory path);
}

class DefaultPackageService implements PackageService {
  const DefaultPackageService();

  @override
  Stream<PackageUpdate> packagesToBeUpdated(Directory path) async* {
    final output = await _getOutdatedPackages(path);

    for (final data in output['packages']) {
      yield PackageUpdate(
        name: data['package'],
        currentVersion: data['current']?['version'],
        upgradableVersion: data['upgradable']?['version'],
        resolvableVersion: data['resolvable']?['version'],
        latestVersion: data['latest']?['version'],
      );
    }
  }

  // TODO: replace it with something more robust
  Future<Map<String, dynamic>> _getOutdatedPackages(Directory path) async {
    final executable = _findPathToPubExecutable();

    if (executable == null) {
      throw const AppException.pubNotFound();
    }

    final result = await Process.run(
      executable,
      const ['pub', 'outdated', '--json'],
      workingDirectory: path.absolute.path,
    );

    return json.decode(result.stdout);
  }

  String? _findPathToPubExecutable() {
    return whichSync('dart') ?? whichSync('flutter');
  }
}
