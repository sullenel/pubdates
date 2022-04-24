part of 'settings_dialog.dart';

// My brain is apparently damaged by Swift
extension _SdkPathExtension on BuildContext {
  void unsetSdkPath() {
    // NOTE: this feels wrong
    read<SettingsBloc>().add(const SettingsEvent.setSdkPath());
  }

  void selectSdkPath() async {
    final dir = await read<PathPicker>().selectDirectory();

    if (dir != null) {
      read<SettingsBloc>().add(SettingsEvent.setSdkPath(path: dir.fullPath));
    }
  }
}

class _SdkPathOption extends StatelessWidget {
  const _SdkPathOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final path = context.select<SettingsBloc, String?>(
      (bloc) => bloc.state.settings.sdkPath,
    );
    final hasSdkPath = path != null;

    return ListTile(
      title: Text(t.sdkPathOption),
      subtitle: hasSdkPath ? Text(path) : Text(t.sdkPathOptionDescription),
      trailing: hasSdkPath
          ? OutlinedButton(
              onPressed: context.unsetSdkPath,
              child: Text(t.unsetAction),
            )
          : OutlinedButton(
              onPressed: context.selectSdkPath,
              child: Text(t.selectAction),
            ),
    );
  }
}
