import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/common/utils/conversion_utils.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';
import 'package:pubdates/features/project/models/package_update.dart';
import 'package:pubdates/features/project/models/project.dart';
import 'package:pubdates/features/project/repositories/project_repository.dart';

export 'package:pubdates/features/project/bloc/project_event.dart';
export 'package:pubdates/features/project/bloc/project_state.dart';

// Flow:
// Once a path to a Dart project is provided, check if it is actually a Dart
// project and whether it contains the pubspec.lock file. Throw an error if not.
// If it is a Dart project, get the list of direct _hosted_ dependencies (both
// regular and dev) from the pubspec.yaml file. Then get the list of packages
// that need to be updated filtering out any that is not in the list of direct
// dependencies. Send the final list to the bloc handling changelogs.

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(const ProjectState.initial()) {
    on<ProjectEvent>(
      (event, emit) => event.map<Future<void>>(
        select: (event) => _handleProjectSelected(event, emit),
        sort: (event) => _handleSort(event, emit),
      ),
      transformer: transformers.sequential(),
    );
  }

  final ProjectRepository _projectRepository;

  Future<void> _handleProjectSelected(
    SelectProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    return state.maybeMap<Future<void>>(
      initial: (_) => _load(event.path, emit),
      loaded: (_) => _load(event.path, emit),
      failed: (_) => _load(event.path, emit),
      orElse: () async {
        // TODO: report as error
      },
    );
  }

  Future<void> _load(Directory path, Emitter<ProjectState> emit) async {
    emit(const ProjectState.loading());

    try {
      // Get packages
      final project = await _projectRepository.getProject(path);
      if (project.hasNoDependencies) {
        // Seems it is a redundant state
        return emit(ProjectState.noDependencies(path: path));
      }

      // Get package updates
      emit(ProjectState.gettingUpdates(path: path, project: project));

      final updates = await _getUpdates(path);
      if (updates.isEmpty) {
        return emit(ProjectState.noUpdates(project: project));
      }

      // FIXME: move to an extension method
      final dependencies = project.dependencies.mapUpdates(updates);
      final devDependencies = project.devDependencies.mapUpdates(updates);
      final updatedProject = project.copyWith(
        dependencies: dependencies,
        devDependencies: devDependencies,
      );

      if (!updatedProject.hasDependenciesToBeUpgraded) {
        return emit(ProjectState.noUpdates(project: updatedProject));
      }

      emit(ProjectState.loaded(project: updatedProject));
    } on AppException catch (error, trace) {
      emit(ProjectState.failed(error: error, path: path, stackTrace: trace));
      rethrow;
    }
  }

  // NOTE: Maybe this should be in the repository?
  Future<Map<String, PackageUpdate>> _getUpdates(Directory path) =>
      _projectRepository
          .getPackageUpdates(path)
          .fold({}, (result, it) => result..putIfAbsent(it.name, () => it));

  Future<void> _handleSort(
    SortProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    return state.mapOrNull<void>(
      loaded: (state) {
        final updatedProject =
            state.project.withDependenciesSortedBy(sorting: event.sorting);

        // Stupid bloc not allowing duplicate states:
        // state.project == updatedProject (yep)
        emit(ProjectState.sorted(project: updatedProject));
        emit(state.copyWith(project: updatedProject));
      },
    );
  }
}

extension on Iterable<Package> {
  List<Package> mapUpdates(Map<String, PackageUpdate> updates) => [
        for (final pkg in this)
          if (updates.containsKey(pkg.name))
            pkg.copyWith(update: updates[pkg.name])
          else
            pkg
      ];
}

extension on Project {
  Project withDependenciesSortedBy({
    PackageSorting sorting = PackageSorting.byName,
  }) {
    switch (sorting) {
      case PackageSorting.byName:
        return _withDependenciesSortedByName;
      case PackageSorting.byUpdateAvailability:
        return _withDependenciesSortedByUpdateAvailability;
    }
  }

  Project get _withDependenciesSortedByName => copyWith(
        dependencies: dependencies.sortedByName,
        devDependencies: devDependencies.sortedByName,
      );

  Project get _withDependenciesSortedByUpdateAvailability => copyWith(
        dependencies: dependencies.sortedByUpdateAvailability,
        devDependencies: devDependencies.sortedByUpdateAvailability,
      );
}

extension on List<Package> {
  List<Package> get sortedByName {
    return toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  List<Package> get sortedByUpdateAvailability {
    return toList()
      ..sort(
        (a, b) => b.canBeUpgraded.toInt().compareTo(a.canBeUpgraded.toInt()),
      );
  }
}
