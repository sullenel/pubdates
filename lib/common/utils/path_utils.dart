import 'dart:io';

import 'package:file_selector/file_selector.dart';

class PathPicker {
  const PathPicker();

  Future<Directory?> selectDirectory() async {
    final path = await getDirectoryPath();
    return path == null ? null : Directory(path);
  }
}

extension DirectoryExtension on Directory {
  String get fullPath => absolute.path;
}
