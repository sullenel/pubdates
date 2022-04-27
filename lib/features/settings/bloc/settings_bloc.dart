import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:pubdates/features/settings/bloc/settings_event.dart';
import 'package:pubdates/features/settings/bloc/settings_state.dart';
import 'package:pubdates/features/settings/repositories/settings_repository.dart';

export 'package:pubdates/features/settings/bloc/settings_event.dart';
export 'package:pubdates/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(SettingsState.initial) {
    on<SettingsEvent>(
      (event, emit) => event.map(
        restore: (event) => _handleRestoreSettings(event, emit),
        setPackageSorting: (event) => _handleSetPackageSorting(event, emit),
        setSdkPath: (event) => _handleSdkPath(event, emit),
        setThemeMode: (event) => _handleSetThemeMode(event, emit),
      ),
      transformer: transformers.sequential(),
    );
  }

  final SettingsRepository _settingsRepository;

  Future<void> _handleRestoreSettings(
    RestoreSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final settings = await _settingsRepository.settings;
    emit(state.copyWith(settings: settings));
  }

  Future<void> _handleSetPackageSorting(
    SetPackageSortingEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings.packageSorting != event.sorting) {
      await _settingsRepository.savePackageSorting(event.sorting);
      final newSettings =
          state.settings.copyWith(packageSorting: event.sorting);
      emit(state.copyWith(settings: newSettings));
    }
  }

  Future<void> _handleSdkPath(
    SetSdkPathEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings.sdkPath != event.path) {
      await _settingsRepository.saveSdkPath(event.path);
      final newSettings = state.settings.copyWith(sdkPath: event.path);
      emit(state.copyWith(settings: newSettings));
    }
  }

  Future<void> _handleSetThemeMode(
    SetThemeModeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings.themeMode != event.themeMode) {
      await _settingsRepository.saveThemeMode(event.themeMode);
      final newSettings = state.settings.copyWith(themeMode: event.themeMode);
      emit(state.copyWith(settings: newSettings));
    }
  }
}
