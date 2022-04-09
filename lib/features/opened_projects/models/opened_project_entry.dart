import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'opened_project_entry.freezed.dart';

@freezed
class OpenedProjectEntry with _$OpenedProjectEntry {
  const OpenedProjectEntry._();

  const factory OpenedProjectEntry({
    required Directory path,
    String? iconPath,
  }) = _OpenedProjectEntry;

  String get fullPath => path.absolute.path;

  String get name => basename(fullPath);

  Future<bool> exists() => path.exists();
}
