import 'dart:convert';
import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/features/project/models/package_update.dart';

mixin SdkSettingsProvider {
  Future<String?> get sdkPath;
}

// Cannot come up with a good name for this as always
mixin PackageService {
  Stream<PackageUpdate> packagesToBeUpdated(Directory path);
}

class DefaultPackageService implements PackageService {
  const DefaultPackageService({
    SdkSettingsProvider? sdkSettings,
  }) : _sdkSettings = sdkSettings;

  final SdkSettingsProvider? _sdkSettings;

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
    final executable = await _findPathToPubExecutable();

    if (executable == null) {
      throw const AppException.pubNotFound();
    }

    try {
      final result = await Process.run(
        executable,
        const ['pub', 'outdated', '--json'],
        workingDirectory: path.absolute.path,
      );

      return json.decode(result.stdout);
    } on ProcessException catch (error, stackTrace) {
      throw const AppException.pubNotFound();
    }
  }

  Future<String?> _findPathToPubExecutable() async {
    final customPath = await _sdkSettings?.sdkPath;
    final environment = customPath == null ? null : {'PATH': customPath};

    return whichSync('dart', environment: environment) ??
        whichSync('flutter', environment: environment);
  }
}
