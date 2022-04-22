import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';

part 'app_settings.freezed.dart';

@freezed
class AppSettings with _$AppSettings {
  static const initial = AppSettings(
    packageSorting: PackageSorting.byName,
    themeMode: ThemeMode.system,
  );

  const AppSettings._();

  const factory AppSettings({
    @Default(PackageSorting.byName) PackageSorting packageSorting,
    @Default(ThemeMode.system) ThemeMode themeMode,
    String? dartPath,
  }) = _AppSettings;
}
