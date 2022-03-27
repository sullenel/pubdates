import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';

part 'opened_projects_event.freezed.dart';

@freezed
class OpenedProjectsEvent with _$OpenedProjectsEvent {
  const OpenedProjectsEvent._();

  /// Emitted when we need to load and check the opened projects.
  const factory OpenedProjectsEvent.loadAll() = LoadAllOpenedProjectsEvent;

  /// Emitted when a valid Dart project has been opened.
  const factory OpenedProjectsEvent.add({
    required Directory path,
  }) = AddOpenedProjectEvent;

  /// Emitted when a project needs to be removed from the list.
  const factory OpenedProjectsEvent.remove({
    required OpenedProjectEntry entry,
  }) = RemoveOpenedProjectEvent;
}
