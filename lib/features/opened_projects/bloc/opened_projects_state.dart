import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';

part 'opened_projects_state.freezed.dart';

@freezed
class OpenedProjectsState with _$OpenedProjectsState {
  static const initial = OpenedProjectsState.loaded();

  const OpenedProjectsState._();

  const factory OpenedProjectsState.loaded({
    @Default(<OpenedProjectEntry>[]) List<OpenedProjectEntry> entries,
  }) = _LoadedOpenedProjectsState;

  bool get isEmpty => map<bool>(loaded: (state) => state.entries.isEmpty);

  bool get isNotEmpty => !isEmpty;
}
