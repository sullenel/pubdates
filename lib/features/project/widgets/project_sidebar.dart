import 'package:flutter/material.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubdates/features/project/widgets/project_dependency_list.dart';

class ProjectSidebar extends StatelessWidget {
  const ProjectSidebar({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

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
        const Expanded(
          flex: 3,
          child: Placeholder(),
        ),
      ],
    );
  }
}
