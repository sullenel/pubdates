import 'package:flutter/material.dart';
import 'package:pubdates/common/persistence/key_value_store.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';
import 'package:pubdates/features/settings/models/app_settings.dart';

class SettingsRepository {
  static String get _prefix => 'settings';
  static String get _sortingKey => '$_prefix.sorting';
  static String get _themeKey => '$_prefix.theme';
  static String get _sdkPathKey => '$_prefix.sdk_path';

  const SettingsRepository({
    required KeyValueStore storage,
    AppSettings defaults = AppSettings.initial,
  })  : _storage = storage,
        _defaults = defaults;

  final KeyValueStore _storage;
  final AppSettings _defaults;

  Future<AppSettings> get settings async {
    return AppSettings(
      packageSorting: await packageSorting,
      themeMode: await themeMode,
      sdkPath: await sdkPath,
    );
  }

  Future<void> savePackageSorting(PackageSorting sorting) {
    return _storage.putString(_sortingKey, sorting.name);
  }

  Future<PackageSorting> get packageSorting async {
    final name = await _storage.getString(_sortingKey);
    return name == null
        ? _defaults.packageSorting
        : PackageSorting.values.byName(name);
  }

  Future<void> saveThemeMode(ThemeMode themeMode) {
    return _storage.putString(_themeKey, themeMode.name);
  }

  Future<ThemeMode> get themeMode async {
    final name = await _storage.getString(_themeKey);
    return name == null ? _defaults.themeMode : ThemeMode.values.byName(name);
  }

  Future<void> saveSdkPath(String? path) {
    if (path == null) {
      return _storage.delete(_sdkPathKey);
    }

    return _storage.putString(_sdkPathKey, path);
  }

  Future<String?> get sdkPath {
    return _storage.getString(_sdkPathKey);
  }
}
