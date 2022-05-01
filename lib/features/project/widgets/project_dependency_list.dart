import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/typedefs.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/widgets/project_dependency_tile.dart';
import 'package:pubdates/features/project/widgets/section_title.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on List<Package> {
  int get totalCount => length;

  int get toBeUpgradedCount => where((it) => it.canBeUpgraded).length;
}

class ProjectDependencyList extends StatelessWidget {
  const ProjectDependencyList({
    Key? key,
    required this.dependencies,
    required this.devDependencies,
    this.onPackagePressed,
  }) : super(key: key);

  final List<Package> dependencies;
  final List<Package> devDependencies;
  final ValueSetter<Package>? onPackagePressed;

  @override
  Widget build(BuildContext context) {
    assert(
      dependencies.isNotEmpty || devDependencies.isNotEmpty,
      'Invalid state: no dependencies should be handled by other widget',
    );

    late final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Material(
      color: theme.appBarTheme.backgroundColor,
      child: CustomScrollView(
        primary: false,
        slivers: [
          if (dependencies.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.all(AppInsets.lg) -
                  const EdgeInsets.only(bottom: AppInsets.lg),
              sliver: SliverBox(
                child: SectionTitle(
                  title: t.dependenciesTitle,
                  trailing: _PackageCount(
                    totalCount: dependencies.totalCount,
                    toBeUpgradedCount: dependencies.toBeUpgradedCount,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: AppInsets.md),
              sliver: _DependencyList(
                dependencies: dependencies,
                onPressed: onPackagePressed,
              ),
            ),
          ],
          if (devDependencies.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.lg) +
                  const EdgeInsets.only(top: AppInsets.md),
              sliver: SliverBox(
                child: SectionTitle(
                  title: t.devDependenciesTitle,
                  trailing: _PackageCount(
                    totalCount: devDependencies.totalCount,
                    toBeUpgradedCount: devDependencies.toBeUpgradedCount,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: AppInsets.md),
              sliver: _DependencyList(
                dependencies: devDependencies,
                onPressed: onPackagePressed,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DependencyList extends StatelessWidget {
  const _DependencyList({
    Key? key,
    required this.dependencies,
    this.onPressed,
  }) : super(key: key);

  final List<Package> dependencies;
  final ValueSetter<Package>? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverPrototypeExtentList(
      prototypeItem: _buildItem(context, 0),
      delegate: SliverChildBuilderDelegate(
        _buildItem,
        childCount: dependencies.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final pkg = dependencies[index];

    return ProjectDependencyTile(
      onPressed:
          onPressed != null && pkg.canBeUpgraded ? () => onPressed!(pkg) : null,
      package: pkg,
    );
  }
}

class _PackageCount extends StatelessWidget {
  const _PackageCount({
    Key? key,
    required this.totalCount,
    this.toBeUpgradedCount = 0,
  }) : super(key: key);

  final int totalCount;
  final int toBeUpgradedCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context);
    final tooltip = t.packageCountTooltip(totalCount, toBeUpgradedCount);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.button,
        color: theme.colorScheme.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm,
          horizontal: AppInsets.md,
        ),
        child: Tooltip(
          message: tooltip,
          child: Text(
            '$totalCount / $toBeUpgradedCount',
            style: theme.textTheme.labelMedium?.copyWith(
              height: 1.4,
              color: theme.colorScheme.onSecondaryContainer,
            ),
            semanticsLabel: tooltip,
          ),
        ),
      ),
    );
  }
}
