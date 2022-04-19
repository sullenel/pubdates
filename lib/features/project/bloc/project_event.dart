import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';

part 'project_event.freezed.dart';

@freezed
class ProjectEvent with _$ProjectEvent {
  const factory ProjectEvent.select({
    required Directory path,
  }) = SelectProjectEvent;

  const factory ProjectEvent.sort({
    required PackageSorting sorting,
  }) = SortProjectsEvent;
}
