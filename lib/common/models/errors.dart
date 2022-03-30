import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'errors.freezed.dart';

@freezed
class AppException with _$AppException implements Exception {
  const AppException._();

  /// Thrown when the Dart is not installed.
  const factory AppException.pubNotFound() = PubNotFoundException;

  /// Thrown when the provided directory is not a Dart project.
  const factory AppException.invalidProject({
    required Directory path,
  }) = InvalidProjectException;

  /// Thrown when the pubspec file cannot be parsed.
  const factory AppException.invalidPubspec({
    required String path,
  }) = InvalidPubspecException;

  /// Thrown when the pubspec file (both yaml and lock) cannot be found.
  const factory AppException.pubspecNotFound({
    required String path,
  }) = PubspecNotFoundException;

  /// Thrown when the provided project directory cannot be found.
  const factory AppException.projectNotFound({
    required Directory path,
  }) = ProjectNotFoundException;

  /// Thrown for yet to be known errors.
  const factory AppException.unknown({
    required Object originalError,
    StackTrace? stackTrace,
  }) = UnknownException;

  // Used for detecting whether the selected project can be removed from the
  // list of opened projects or not.
  bool get isProjectNotAvailable => maybeMap<bool>(
        invalidProject: (_) => true,
        projectNotFound: (_) => true,
        orElse: () => false,
      );
}
