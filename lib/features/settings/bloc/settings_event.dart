import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const SettingsEvent._();

  const factory SettingsEvent.restore() = RestoreSettingsEvent;

  const factory SettingsEvent.setPackageSorting({
    required PackageSorting sorting,
  }) = SetPackageSortingEvent;

  const factory SettingsEvent.setThemeMode({
    required ThemeMode themeMode,
  }) = SetThemeModeEvent;

  const factory SettingsEvent.setSdkPath({
    String? path,
  }) = SetSdkPathEvent;
}
