import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/features/home/widgets/app_scope.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on BuildContext {
  List<OpenedProjectEntry> get openedProjects =>
      select<OpenedProjectsBloc, List<OpenedProjectEntry>>(
        (bloc) => bloc.state.entries,
      );
}

class AppMenuBar extends StatefulWidget {
  const AppMenuBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<AppMenuBar> createState() => _AppMenuBarState();
}

class _AppMenuBarState extends State<AppMenuBar> {
  bool get _hasAbout => PlatformProvidedMenuItem.hasMenu(
        PlatformProvidedMenuItemType.about,
      );

  bool get _canQuit => PlatformProvidedMenuItem.hasMenu(
        PlatformProvidedMenuItemType.quit,
      );

  void _handleShowSettings() {
    AppScope.openSettings(context);
  }

  void _handleSelectProject() async {
    AppScope.selectProject(context);
  }

  void _handleOpenProject(Directory path) {
    AppScope.openProject(context, path: path);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final openedProjects = context.openedProjects;

    return PlatformMenuBar(
      menus: <MenuItem>[
        // Main menu
        PlatformMenu(
          label: t.appTitle,
          menus: <MenuItem>[
            if (_hasAbout)
              const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.about,
              ),
            PlatformMenuItemGroup(
              members: <MenuItem>[
                PlatformMenuItem(
                  onSelected: _handleShowSettings,
                  shortcut: AppShortcuts.settings,
                  label: t.menuBarPreferencesAction,
                ),
              ],
            ),
            if (_canQuit)
              const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.quit,
              ),
          ],
        ),

        // File menu
        PlatformMenu(
          label: t.menuBarFileSectionTitle,
          menus: [
            PlatformMenuItem(
              onSelected: _handleSelectProject,
              label: t.menuBarOpenProjectAction,
              shortcut: AppShortcuts.open,
            ),

            // Recently opened projects
            if (openedProjects.isNotEmpty)
              PlatformMenuItemGroup(
                members: [
                  PlatformMenu(
                    label: t.menuBarOpenRecentAction,
                    menus: [
                      for (final it in openedProjects)
                        PlatformMenuItem(
                          onSelected: () => _handleOpenProject(it.path),
                          label: it.name,
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ],
      body: widget.child,
    );
  }
}
