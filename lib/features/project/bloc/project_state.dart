import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/features/project/models/project.dart';

part 'project_state.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const ProjectState._();

  const factory ProjectState.initial() = _InitialProjectState;

  const factory ProjectState.noDependencies({
    required Directory path,
  }) = _NoDependenciesState;

  const factory ProjectState.loading() = _GettingDependenciesState;

  const factory ProjectState.gettingUpdates({
    required Directory path,
    required Project project,
  }) = _GettingDependencyUpdatesState;

  const factory ProjectState.noUpdates({
    required Project project,
  }) = _NoDependencyUpdatesState;

  const factory ProjectState.loaded({
    required Project project,
  }) = _ProjectLoadedState;

  // A temporary state mostly for informing interested parties.
  const factory ProjectState.sorted({
    required Project project,
  }) = _ProjectSortedState;

  // Emitted when the provided path does not have the pubspec.yaml and
  // pubspec.lock files. The pubspec.lock is required since without it the app
  // is meaningless.
  const factory ProjectState.failed({
    required AppException error,
    required Directory path,
    StackTrace? stackTrace,
  }) = _FailedProjectState;

  String? get projectName => mapOrNull(
        gettingUpdates: (state) => state.project.name,
        noUpdates: (state) => state.project.name,
        loaded: (state) => state.project.name,
      );

  bool get canSortPackages => maybeMap<bool>(
        loaded: (_) => true,
        orElse: () => false,
      );

  Project? get project => map<Project?>(
        initial: (_) => null,
        noDependencies: (_) => null,
        loading: (_) => null,
        gettingUpdates: (state) => state.project,
        noUpdates: (state) => state.project,
        loaded: (state) => state.project,
        sorted: (state) => state.project,
        failed: (_) => null,
      );

  String? get title => project?.name;
}
