import 'package:flutter/material.dart';
import 'package:pubdates/features/project/models/project.dart';
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
    return Row(
      children: [
        Expanded(
          child: ProjectDependencyList(
            dependencies: project.dependencies,
            devDependencies: project.devDependencies,
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
