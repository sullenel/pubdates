import 'package:flutter/material.dart';
import 'package:pubdates/common/utils/typedefs.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/widgets/project_dependency_tile.dart';
import 'package:pubdates/features/project/widgets/section_title.dart';
import 'package:pubdates/localization/app_localizations.dart';

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

    return Scrollbar(
      child: CustomScrollView(
        slivers: [
          if (dependencies.isNotEmpty) ...[
            SliverBox(child: SectionTitle(title: t.dependenciesTitle)),
            _DependencyList(dependencies: dependencies),
          ],
          if (devDependencies.isNotEmpty) ...[
            SliverBox(child: SectionTitle(title: t.devDependenciesTitle)),
            _DependencyList(dependencies: devDependencies),
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
      onPressed: onPressed == null ? null : () => onPressed!(pkg),
      package: pkg,
    );
  }
}
