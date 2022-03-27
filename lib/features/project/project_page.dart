import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/common/utils/scroll_utils.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/features/changelog/bloc/changelog_bloc.dart';
import 'package:pubdates/features/changelog/bloc/changelog_event.dart';
import 'package:pubdates/features/changelog/repositories/changelog_repository.dart';
import 'package:pubdates/features/changelog/services/changelog_parser.dart';
import 'package:pubdates/features/changelog/services/changelog_provider.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
import 'package:pubdates/features/changelog/widgets/changelog_list.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/widgets/invalid_project.dart';
import 'package:pubdates/features/project/widgets/project_no_dependencies.dart';
import 'package:pubdates/features/project/widgets/project_no_updates.dart';
import 'package:pubdates/features/project/widgets/project_not_selected.dart';
import 'package:pubdates/features/project/widgets/project_content.dart';

extension on BuildContext {
  ProjectBloc get projectBloc => this.read();

  ChangeLogBloc get changeLogBloc => this.read();

  OpenedProjectsBloc get projectsBloc => this.read();
}

class ProjectPage extends StatefulWidget {
  static Route<T> route<T>(Directory path) {
    return MaterialPageRoute(
      builder: (context) {
        return MultiProvider(
          providers: [
            Provider<ScrollManager<Package>>(
              create: (_) => ScrollManager<Package>(
                keyExtractor: (it) => it.name,
              ),
              dispose: (_, provider) => provider.dispose(),
            ),
            Provider<Client>(
              create: (_) => Client(),
              dispose: (_, provider) => provider.close(),
            ),
          ],
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<ChangeLogRepository>(
                create: (context) => ChangeLogRepository(
                  remoteChangeLogProvider: RemoteChangeLogProvider(
                    client: context.read(),
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
                  )..add(ProjectEvent.select(path: path)),
                ),
                BlocProvider<ChangeLogBloc>(
                  create: (context) => ChangeLogBloc(
                    changeLogRepository: context.read(),
                  ),
                ),
              ],
              child: const ProjectPage(),
            ),
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
    final path = await context.read<PathPicker>().selectDirectory();

    if (path != null) {
      context.projectBloc.add(ProjectEvent.select(path: path));
      // TODO: move to _handleProjectState once state fields are adjusted
      context.projectsBloc.add(OpenedProjectsEvent.add(path: path));
    }
  }

  void _handleProjectState(BuildContext context, ProjectState state) {
    state.mapOrNull(
      loaded: (state) {
        final packages = state.project.dependenciesToBeUpgraded;
        context.read<ScrollManager<Package>>().addAll(packages);
        context.changeLogBloc.add(ChangeLogEvent.loadAll(packages: packages));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        AppShortcuts.close: Navigator.of(context).pop,
      },
      child: Focus(
        autofocus: true,
        child: Material(
          child: BlocConsumer<ProjectBloc, ProjectState>(
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
                  child: const ProjectNoUpdates(),
                ),
                loaded: (state) => ProjectContent(
                  project: state.project,
                  child: const ChangeLogList(),
                ),
                failed: (state) => InvalidProject(error: state.error),
              );
            },
          ),
        ),
      ),
    );
  }
}
