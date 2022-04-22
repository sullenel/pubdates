import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';
import 'package:pubdates/features/settings/bloc/settings_bloc.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on BuildContext {
  bool get canSortPackages {
    return select<ProjectBloc, bool>((bloc) => bloc.state.canSortPackages);
  }

  PackageSorting get currentPackageSorting {
    return select<SettingsBloc, PackageSorting>(
      (bloc) => bloc.state.settings.packageSorting,
    );
  }

  void changePackageSorting(PackageSorting sorting) {
    read<SettingsBloc>().add(SettingsEvent.setPackageSorting(sorting: sorting));
  }
}

class SortPackagesAction extends StatelessWidget {
  const SortPackagesAction({
    Key? key,
    this.sortingOptions = PackageSorting.values,
  }) : super(key: key);

  final List<PackageSorting> sortingOptions;

  @override
  Widget build(BuildContext context) {
    late final t = AppLocalizations.of(context);

    return PopupMenuButton<PackageSorting>(
      onSelected: context.changePackageSorting,
      enabled: context.canSortPackages,
      initialValue: context.currentPackageSorting,
      icon: const Icon(AppIcons.sort),
      tooltip: t.sortPackagesTooltip,
      itemBuilder: (context) => [
        for (final option in sortingOptions)
          PopupMenuItem(
            child: Text(t.packageSortingName(option)),
            value: option,
          ),
      ],
    );
  }
}
