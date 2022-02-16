import 'package:bloc/bloc.dart';
import 'package:pubdates/features/project/bloc/project_event.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';
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
        emit(const ProjectState.gettingDependencies());

        try {
          final project = await _projectRepository.getProject(event.path);

          if (project.hasNoDependencies) {
            return emit(const ProjectState.empty());
          }

          emit(ProjectState.gettingUpdates(project: project));

          // Get updates
          final updates =
              await _projectRepository.getPackageUpdates(event.path).toList();
        } on Object catch (error, stackTrace) {
          // TODO:
        }
      },
    );
  }
}
