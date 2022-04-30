import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/features/home/widgets/home_header.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/features/opened_projects/widgets/opened_projects_list.dart';
import 'package:pubdates/features/project/project_page.dart';
import 'package:pubdates/features/settings/widgets/settings_dialog.dart';

extension on BuildContext {
  bool get hasOpenedProjects =>
      select<OpenedProjectsBloc, bool>((bloc) => bloc.state.isNotEmpty);

  OpenedProjectsBloc get openedProjectsBloc => read();
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void _handleSelectProject() async {
    final path = await context.read<PathPicker>().selectDirectory();

    if (path != null) {
      _handleOpenProject(path);
    }
  }

  void _handleOpenProject(Directory path) {
    Navigator.of(context).push(ProjectPage.route(path));
  }

  void _handleDeleteOpenedProject(OpenedProjectEntry project) {
    context.openedProjectsBloc
        .add(OpenedProjectsEvent.remove(path: project.path));
  }

  void _handleOpenSettings() {
    const SettingsDialog().asDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final hasOpenedProjects = context.hasOpenedProjects;

    // No need for FocusableActionDetector for now
    return CallbackShortcuts(
      bindings: {
        AppShortcuts.open: _handleSelectProject,
        AppShortcuts.settings: _handleOpenSettings,
      },
      child: Focus(
        autofocus: true,
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppInsets.lg),
                  child: HomeHeader(onSelectPressed: _handleSelectProject),
                ),
              ),
              if (hasOpenedProjects)
                Expanded(
                  flex: 2,
                  child: OpenedProjectsList(
                    onSelect: _handleOpenProject,
                    onDelete: _handleDeleteOpenedProject,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
