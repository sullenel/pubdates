import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
import 'package:pubdates/features/project/widgets/invalid_project.dart';
import 'package:pubdates/features/project/widgets/project_app_bar.dart';
import 'package:pubdates/features/project/widgets/project_no_dependencies.dart';
import 'package:pubdates/features/project/widgets/project_not_selected.dart';
import 'package:pubdates/features/project/widgets/project_content.dart';

class ProjectPage extends StatefulWidget {
  static Route<T> route<T>(String path) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => ProjectBloc(
            projectRepository: context.read(),
          )..add(ProjectEvent.select(path: Directory(path))),
          child: const ProjectPage(),
        );
      },
    );
  }

  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  void _handleSelectProject() async {
    // TODO: abstract away
    final dir = await getDirectoryPath();

    if (dir != null) {
      context
          .read<ProjectBloc>()
          .add(ProjectEvent.select(path: Directory(dir)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProjectAppBar(),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => ProjectNotSelected(onSelect: _handleSelectProject),
            noDependencies: (_) => const ProjectHasNoDependencies(),
            loading: (_) => const LoadingIndicator(),
            gettingUpdates: (state) => ProjectContent(
              project: state.project,
              child: const LoadingIndicator(),
            ),
            noUpdates: (state) => ProjectContent(
              project: state.project,
              child: Text('No updates'),
            ),
            loaded: (state) => ProjectContent(
              project: state.project,
              child: Placeholder(),
            ),
            invalidProject: (_) => const InvalidProject(),
          );
        },
      ),
    );
  }
}
