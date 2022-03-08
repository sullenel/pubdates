import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/project/models/package.dart';

part 'changelog_state.freezed.dart';

@freezed
class ChangeLogState with _$ChangeLogState {
  const factory ChangeLogState.waitingForPackages() = _WaitingForPackagesState;

  const factory ChangeLogState.loading({
    required Queue<Package> pending,
    required List<PackageChangeLog> loaded,
  }) = _LoadingChangeLogsState;

  const factory ChangeLogState.loaded({
    required List<PackageChangeLog> loaded,
  }) = _LoadedChangeLogsState;
}
