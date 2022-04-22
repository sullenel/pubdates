import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/settings/models/app_settings.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  static SettingsState get initial => const SettingsState(AppSettings.initial);

  const SettingsState._();

  const factory SettingsState(AppSettings settings) = _SettingsState;
}
