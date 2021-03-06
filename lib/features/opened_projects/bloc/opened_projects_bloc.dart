import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:pubdates/features/opened_projects/bloc/opened_projects_event.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_state.dart';
import 'package:pubdates/features/opened_projects/repositories/open_projects_repository.dart';
export 'package:pubdates/features/opened_projects/bloc/opened_projects_event.dart';
export 'package:pubdates/features/opened_projects/bloc/opened_projects_state.dart';

class OpenedProjectsBloc
    extends Bloc<OpenedProjectsEvent, OpenedProjectsState> {
  OpenedProjectsBloc({
    required OpenProjectsRepository projectsRepository,
  })  : _projectsRepository = projectsRepository,
        super(OpenedProjectsState.initial) {
    on<OpenedProjectsEvent>(
      (event, emit) => event.map<Future<void>>(
        add: (event) => _handleAddProject(event, emit),
        remove: (event) => _handleRemoveProject(event, emit),
        loadAll: (event) => _handleLoadAll(event, emit),
      ),
      transformer: transformers.sequential(),
    );
  }

  final OpenProjectsRepository _projectsRepository;

  Future<void> _handleAddProject(
    AddOpenedProjectEvent event,
    Emitter<OpenedProjectsState> emit,
  ) async {
    return state.mapOrNull<Future<void>>(
      loaded: (state) async {
        if (state.contains(event.path)) return;

        await _projectsRepository.add(event.path);
        final entries = await _projectsRepository.allProjects().toList();
        emit(state.copyWith(entries: entries));
      },
    );
  }

  Future<void> _handleRemoveProject(
    RemoveOpenedProjectEvent event,
    Emitter<OpenedProjectsState> emit,
  ) async {
    return state.mapOrNull<Future<void>>(
      loaded: (state) async {
        await _projectsRepository.remove(event.path);
        final entries = await _projectsRepository.allProjects().toList();
        emit(state.copyWith(entries: entries));
      },
    );
  }

  Future<void> _handleLoadAll(
    LoadAllOpenedProjectsEvent event,
    Emitter<OpenedProjectsState> emit,
  ) async {
    final entries = await _projectsRepository.allActiveProjects().toList();
    emit(OpenedProjectsState.loaded(entries: entries));
  }
}
