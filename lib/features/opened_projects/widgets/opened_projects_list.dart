import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/features/opened_projects/widgets/opened_project_tile.dart';
import 'package:pubdates/features/project/widgets/section_title.dart';
import 'package:pubdates/localization/app_localizations.dart';

class OpenedProjectsList extends StatelessWidget {
  const OpenedProjectsList({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  final ValueSetter<Directory> onSelect;

  void _handleSelectProject(OpenedProjectEntry project) {
    onSelect(project.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenedProjectsBloc, OpenedProjectsState>(
      builder: (context, state) {
        return state.map(
          loaded: (state) {
            final entries = state.entries;

            if (entries.isEmpty) {
              return Nothing;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppInsets.lg) -
                      const EdgeInsets.only(bottom: AppInsets.lg),
                  child: SectionTitle(
                    title: AppLocalizations.of(context).recent,
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: _ProjectList(
                      onSelect: _handleSelectProject,
                      entries: entries,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ProjectList extends StatelessWidget {
  const _ProjectList({
    Key? key,
    required this.entries,
    required this.onSelect,
  }) : super(key: key);

  final List<OpenedProjectEntry> entries;
  final ValueSetter<OpenedProjectEntry> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppInsets.lg),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const VSpace(AppInsets.lg),
      itemBuilder: (context, index) {
        final entry = entries[index];

        return OpenedProjectTile(
          onPressed: () => onSelect(entry),
          entry: entry,
        );
      },
    );
  }
}
