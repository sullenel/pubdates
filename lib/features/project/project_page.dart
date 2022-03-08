import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:http/http.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/features/changelog/bloc/changelog_bloc.dart';
import 'package:pubdates/features/changelog/bloc/changelog_event.dart';
import 'package:pubdates/features/changelog/repositories/changelog_repository.dart';
import 'package:pubdates/features/changelog/services/changelog_parser.dart';
import 'package:pubdates/features/changelog/services/changelog_provider.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
import 'package:pubdates/features/project/widgets/changelog_list.dart';
import 'package:pubdates/features/project/widgets/invalid_project.dart';
import 'package:pubdates/features/project/widgets/project_app_bar.dart';
import 'package:pubdates/features/project/widgets/project_no_dependencies.dart';
import 'package:pubdates/features/project/widgets/project_not_selected.dart';
import 'package:pubdates/features/project/widgets/project_content.dart';

class ProjectPage extends StatefulWidget {
  static Route<T> route<T>(String path) {
    return MaterialPageRoute(
      builder: (context) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ChangeLogRepository>(
              create: (context) => ChangeLogRepository(
                remoteChangeLogProvider: RemoteChangeLogProvider(
                  client: Client(),
                  parser: const ChangeLogParser(),
                ),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ProjectBloc>(
                create: (context) => ProjectBloc(
                  projectRepository: context.read(),
                )..add(ProjectEvent.select(path: Directory(path))),
              ),
              BlocProvider<ChangeLogBloc>(
                create: (context) => ChangeLogBloc(
                  changeLogRepository: context.read(),
                ),
              ),
            ],
            child: const ProjectPage(),
          ),
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

  void _handleProjectState(BuildContext context, ProjectState state) {
    state.mapOrNull(
      loaded: (state) => context.read<ChangeLogBloc>().add(
            ChangeLogEvent.loadAll(
              packages: state.project.dependenciesToBeUpgraded,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProjectAppBar(),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener: _handleProjectState,
        builder: (context, state) {
          return state.map(
            initial: (_) => ProjectNotSelected(
              onSelect: _handleSelectProject,
            ),
            noDependencies: (_) => const ProjectHasNoDependencies(),
            loading: (_) => const LoadingIndicator(),
            gettingUpdates: (state) => ProjectContent(
              project: state.project,
              child: const LoadingIndicator(),
            ),
            noUpdates: (state) => ProjectContent(
              project: state.project,
              child: const Text('No updates'),
            ),
            loaded: (state) => ProjectContent(
              project: state.project,
              child: const ChangeLogList(),
            ),
            invalidProject: (_) => const InvalidProject(),
          );
        },
      ),
    );
  }
}
