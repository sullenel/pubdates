import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/project.dart';

part 'project_state.freezed.dart';

// TODO: replace
typedef AppError = dynamic;

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState.initial() = _NotProjectState;

  const factory ProjectState.empty() = _NoDependenciesState;

  const factory ProjectState.gettingDependencies() = _GettingDependenciesState;

  const factory ProjectState.gettingUpdates({
    required Project project,
  }) = _GettingDependencyUpdatesState;

  const factory ProjectState.loaded({
    required Project project,
  }) = _ProjectLoadedState;

  // Emitted when the provided path does not have the pubspec.yaml and
  // pubspec.lock files. The pubspec.lock is required since without it the app
  // is meaningless.
  const factory ProjectState.invalidProject({
    required AppError error,
    required Directory path,
  }) = _InvalidProjectState;
}
