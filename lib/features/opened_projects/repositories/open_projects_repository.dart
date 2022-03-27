import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';

class OpenProjectsRepository {
  var _projects = <OpenedProjectEntry>[];

  Stream<OpenedProjectEntry> allProjects() {
    return Stream.fromIterable(_projects);
  }

  Stream<OpenedProjectEntry> allActiveProjects() async* {
    await for (final project in allProjects()) {
      if (await project.exists()) {
        yield project;
      } else {
        await remove(project);
      }
    }
  }

  Future<void> add(OpenedProjectEntry project) async {
    _projects = [project, ..._projects];
  }

  Future<void> remove(OpenedProjectEntry project) async {
    _projects = _projects.where((it) => it != project).toList();
  }

  Future<void> clear() async {
    _projects = [];
  }
}
