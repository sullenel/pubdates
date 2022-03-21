import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/utils/scroll_utils.dart';
import 'package:pubdates/common/widgets/responsive_layout_builder.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubdates/features/project/widgets/project_app_bar.dart';
import 'package:pubdates/features/project/widgets/project_dependency_list.dart';

class ProjectContent extends StatelessWidget {
  const ProjectContent({
    Key? key,
    required this.project,
    required this.child,
  }) : super(key: key);

  final Project project;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, _) => _CompactProjectContent(
        project: project,
        child: child,
      ),
      large: (context, _) => _DefaultProjectContent(
        project: project,
        child: child,
      ),
    );
  }
}

class _CompactProjectContent extends StatelessWidget {
  const _CompactProjectContent({
    Key? key,
    required this.project,
    required this.child,
  }) : super(key: key);

  final Project project;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProjectAppBar(withCloseAction: true),
      drawer: Drawer(
        child: ProjectDependencyList(
          onPackagePressed: (pkg) {
            Navigator.of(context).pop();
            if (pkg.canBeUpgraded) {
              context.read<ScrollManager<Package>>().scrollTo(pkg);
            }
          },
          dependencies: project.dependencies,
          devDependencies: project.devDependencies,
        ),
      ),
      body: child,
    );
  }
}

class _DefaultProjectContent extends StatelessWidget {
  const _DefaultProjectContent({
    Key? key,
    required this.project,
    required this.child,
  }) : super(key: key);

  final Project project;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Scaffold(
            appBar: const ProjectAppBar(),
            body: ProjectDependencyList(
              onPackagePressed: (pkg) {
                if (pkg.canBeUpgraded) {
                  context.read<ScrollManager<Package>>().scrollTo(pkg);
                }
              },
              dependencies: project.dependencies,
              devDependencies: project.devDependencies,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: child,
        ),
      ],
    );
  }
}
