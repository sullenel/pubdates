import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/constants.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/common/widgets/responsive_layout_builder.dart';
import 'package:pubdates/features/home/widgets/app_scope.dart';
import 'package:pubdates/features/home/widgets/home_header.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/models/opened_project.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/features/opened_projects/widgets/opened_projects_list.dart';

extension on BuildContext {
  OpenedProjectsBloc get openedProjectsBloc => read();
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void _handleSelectProject() {
    AppScope.selectProject(context);
  }

  void _handleOpenProject(Directory path) {
    AppScope.openProject(context, path: path);
  }

  void _handleDeleteOpenedProject(OpenedProjectEntry project) {
    context.openedProjectsBloc
        .add(OpenedProjectsEvent.remove(path: project.path));
  }

  void _handleOpenSettings() {
    AppScope.openSettings(context);
  }

  @override
  Widget build(BuildContext context) {
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
          child: BlocSelector<OpenedProjectsBloc, OpenedProjectsState, bool>(
            selector: (state) => state.isNotEmpty,
            builder: (context, hasOpenedProjects) => ResponsiveLayoutBuilder(
              small: (context, child) => _HomeBodyLayout(
                onSelectProject: _handleSelectProject,
                onOpenProject: _handleOpenProject,
                onDeleteOpenedProject: _handleDeleteOpenedProject,
                showOpenedProjects: hasOpenedProjects,
                direction: Axis.vertical,
              ),
              large: (context, child) => _HomeBodyLayout(
                onSelectProject: _handleSelectProject,
                onOpenProject: _handleOpenProject,
                onDeleteOpenedProject: _handleDeleteOpenedProject,
                showOpenedProjects: hasOpenedProjects,
                direction: Axis.horizontal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeBodyLayout extends StatelessWidget {
  const _HomeBodyLayout({
    super.key,
    required this.onOpenProject,
    required this.onDeleteOpenedProject,
    this.onSelectProject,
    this.showOpenedProjects = false,
    this.direction = Axis.vertical,
  });

  final VoidCallback? onSelectProject;
  final ValueSetter<OpenedProject> onOpenProject;
  final ValueSetter<OpenedProjectEntry> onDeleteOpenedProject;
  final bool showOpenedProjects;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    // The poor man's responsive layout :)
    return Flex(
      direction: direction,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppInsets.lg),
            child: HomeHeader(onSelectPressed: onSelectProject),
          ),
        ),
        Flexible(
          flex: showOpenedProjects ? 2 : 0,
          child: AnimatedSize(
            duration: AppConstants.defaultAnimationDuration,
            curve: Curves.easeInOut,
            child: OpenedProjectsList(
              onSelect: onOpenProject,
              onDelete: onDeleteOpenedProject,
            ),
          ),
        ),
      ],
    );
  }
}
