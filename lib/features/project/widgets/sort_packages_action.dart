import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on BuildContext {
  bool get canSortPackages =>
      select<ProjectBloc, bool>((bloc) => bloc.state.canSortPackages);
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

    // TODO: read the initial/current value from settings bloc once implemented
    return PopupMenuButton<PackageSorting>(
      enabled: context.canSortPackages,
      onSelected: (option) {
        context.read<ProjectBloc>().add(ProjectEvent.sort(sorting: option));
      },
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
