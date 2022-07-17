import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/widgets/limited_width.dart';
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
    required this.onDelete,
    this.maxWidth = 600,
  }) : super(key: key);

  final ValueSetter<Directory> onSelect;
  final ValueSetter<OpenedProjectEntry> onDelete;
  final double maxWidth;

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

            // NOTE: don't limit the width of the entire column, or else the
            // scrollbar of the listview will end up in the center.
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppInsets.lg).copyWith(
                    bottom: 0,
                  ),
                  child: LimitedWidth(
                    maxWidth: maxWidth,
                    child: SectionTitle(
                      title: AppLocalizations.of(context).recent,
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: _ProjectList(
                      onSelect: _handleSelectProject,
                      onDelete: onDelete,
                      entries: entries,
                      maxWidth: maxWidth,
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
    this.onDelete,
    this.maxWidth = double.infinity,
  }) : super(key: key);

  final List<OpenedProjectEntry> entries;
  final ValueSetter<OpenedProjectEntry> onSelect;
  final ValueSetter<OpenedProjectEntry>? onDelete;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppInsets.lg),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const VSpace(AppInsets.lg),
      itemBuilder: (context, index) {
        final entry = entries[index];

        return LimitedWidth(
          maxWidth: maxWidth,
          child: OpenedProjectTile(
            onPressed: () => onSelect(entry),
            onDelete: onDelete == null ? null : () => onDelete!(entry),
            entry: entry,
          ),
        );
      },
    );
  }
}
