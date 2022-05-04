part of 'settings_dialog.dart';

extension _ThemeExtension on BuildContext {
  void updateThemeMode(ThemeMode? mode) {
    if (mode != null) {
      read<SettingsBloc>().add(SettingsEvent.setThemeMode(themeMode: mode));
    }
  }
}

class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final selectedMode = context.select<SettingsBloc, ThemeMode>(
      (bloc) => bloc.state.settings.themeMode,
    );

    return ListTile(
      title: Text(t.themeOption),
      trailing: CustomDropdown<ThemeMode>(
        onChanged: context.updateThemeMode,
        selectedValue: selectedMode,
        items: [
          for (final option in ThemeMode.values)
            DropdownMenuItem(
              value: option,
              enabled: option != selectedMode,
              child: Text(t.themeModeName(option)),
            ),
        ],
      ),
    );
  }
}
