import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package.dart';

part 'project.freezed.dart';

// NOTE: no idea how to get changelogs for git, path, and sdk dependencies,
// so they are ignored.

@freezed
class Project with _$Project {
  const Project._();

  const factory Project({
    required String name,
    String? description,
    required List<Package> dependencies,
    required List<Package> devDependencies,
  }) = _Project;

  bool get hasNoDependencies {
    return dependencies.isEmpty && devDependencies.isEmpty;
  }
}
