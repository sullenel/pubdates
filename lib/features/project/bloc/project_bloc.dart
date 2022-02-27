import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/models/package_update.dart';
import 'package:pubdates/features/project/repositories/project_repository.dart';

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
      (event, emit) => event.map(
        select: (event) => _handleProjectSelected(event, emit),
      ),
      transformer: transformers.sequential(),
    );
  }

  final ProjectRepository _projectRepository;

  Future<void> _handleProjectSelected(
    SelectProjectEvent event,
    Emitter emit,
  ) async {
    return state.maybeMap<Future<void>>(
      orElse: () async {
        // TODO: report as error
      },
      initial: (state) async {
        emit(const ProjectState.loading());

        try {
          // Get packages
          final project = await _projectRepository.getProject(event.path);

          if (project.hasNoDependencies) {
            return emit(const ProjectState.noDependencies());
          }

          emit(ProjectState.gettingUpdates(project: project));

          // Get package updates
          final updates = await _getUpdates(event.path);

          if (updates.isEmpty) {
            return emit(ProjectState.noUpdates(project: project));
          }

          final dependencies = project.dependencies.mapUpdates(updates);
          final devDependencies = project.devDependencies.mapUpdates(updates);
          final updatedProject = project.copyWith(
            dependencies: dependencies,
            devDependencies: devDependencies,
          );

          emit(ProjectState.loaded(project: updatedProject));
        } on Object catch (error, stackTrace) {
          print(error);
          print(stackTrace);
          // TODO:
        }
      },
    );
  }

  // NOTE: Maybe this should be in the repository?
  Future<Map<String, PackageUpdate>> _getUpdates(Directory path) =>
      _projectRepository
          .getPackageUpdates(path)
          .fold({}, (result, it) => result..putIfAbsent(it.name, () => it));
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
