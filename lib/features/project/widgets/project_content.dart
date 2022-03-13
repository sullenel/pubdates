import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/utils/scroll_utils.dart';
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
    final sidebar = Scaffold(
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
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // TODO: add responsiveness
        return Row(
          children: [
            Expanded(child: sidebar),
            Expanded(flex: 3, child: child),
          ],
        );
      },
    );
  }
}
