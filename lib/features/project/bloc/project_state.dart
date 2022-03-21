import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/features/project/models/project.dart';

part 'project_state.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const ProjectState._();

  const factory ProjectState.initial() = _InitialProjectState;

  const factory ProjectState.noDependencies() = _NoDependenciesState;

  const factory ProjectState.loading() = _GettingDependenciesState;

  const factory ProjectState.gettingUpdates({
    required Project project,
  }) = _GettingDependencyUpdatesState;

  const factory ProjectState.noUpdates({
    required Project project,
  }) = _NoDependencyUpdatesState;

  const factory ProjectState.loaded({
    required Project project,
  }) = _ProjectLoadedState;

  // Emitted when the provided path does not have the pubspec.yaml and
  // pubspec.lock files. The pubspec.lock is required since without it the app
  // is meaningless.
  const factory ProjectState.failed({
    required AppException error,
    required Directory path,
  }) = _FailedProjectState;

  String? get projectName => mapOrNull(
        gettingUpdates: (state) => state.project.name,
        noUpdates: (state) => state.project.name,
        loaded: (state) => state.project.name,
      );
}
