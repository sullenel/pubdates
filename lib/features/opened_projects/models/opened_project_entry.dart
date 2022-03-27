import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'opened_project_entry.freezed.dart';

@freezed
class OpenedProjectEntry with _$OpenedProjectEntry {
  const OpenedProjectEntry._();

  const factory OpenedProjectEntry({
    required Directory path,
  }) = _OpenedProjectEntry;

  String get fullPath => path.absolute.path;

  // FIXME: find a more reliable way to get the project icon
  String get iconPath => join(
        fullPath,
        'android',
        'app',
        'src',
        'main',
        'res',
        'mipmap-mdpi',
        'ic_launcher.png',
      );

  String get name => basename(fullPath);

  Future<bool> exists() => path.exists();
}
