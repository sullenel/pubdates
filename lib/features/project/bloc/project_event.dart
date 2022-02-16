import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_event.freezed.dart';

@freezed
class ProjectEvent with _$ProjectEvent {
  const factory ProjectEvent.select({
    required Directory path,
  }) = SelectProjectEvent;
}
