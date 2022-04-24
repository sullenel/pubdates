part of 'settings_dialog.dart';

extension _PackageSortingExtension on BuildContext {
  void updatePackageSorting(PackageSorting? sorting) {
    if (sorting != null) {
      read<SettingsBloc>()
          .add(SettingsEvent.setPackageSorting(sorting: sorting));
    }
  }
}

class _PackageSortingOption extends StatelessWidget {
  const _PackageSortingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final selected = context.select<SettingsBloc, PackageSorting>(
      (bloc) => bloc.state.settings.packageSorting,
    );

    return ListTile(
      title: Text(t.packageSortingOption),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<PackageSorting>(
          onChanged: context.updatePackageSorting,
          value: selected,
          focusColor: AppColors.transparent,
          alignment: Alignment.centerRight,
          items: [
            for (final option in PackageSorting.values)
              DropdownMenuItem(
                value: option,
                enabled: option != selected,
                child: Text(t.packageSortingName(option)),
              ),
          ],
        ),
      ),
    );
  }
}
