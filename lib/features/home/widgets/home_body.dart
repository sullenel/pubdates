import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/features/home/widgets/home_header.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/widgets/opened_projects_list.dart';
import 'package:pubdates/features/project/project_page.dart';

extension on BuildContext {
  bool get hasOpenedProjects =>
      select<OpenedProjectsBloc, bool>((bloc) => bloc.state.isNotEmpty);
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
    // TODO: remove this
    context.read<OpenedProjectsBloc>().add(OpenedProjectsEvent.add(path: path));
    Navigator.of(context).push(ProjectPage.route(path));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final hasOpenedProjects = context.hasOpenedProjects;

    // No need for FocusableActionDetector for now
    return CallbackShortcuts(
      bindings: {
        AppShortcuts.open: _handleSelectProject,
      },
      child: Focus(
        autofocus: true,
        child: ColoredBox(
          color: colors.secondary,
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
                    // TODO: Limit the width of the project list
                    child: OpenedProjectsList(onSelect: _handleOpenProject),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
