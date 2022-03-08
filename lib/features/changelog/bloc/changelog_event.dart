import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package.dart';

part 'changelog_event.freezed.dart';

@freezed
class ChangeLogEvent with _$ChangeLogEvent {
  const ChangeLogEvent._();

  const factory ChangeLogEvent.load({
    required Package package,
  }) = _LoadChangeLogEvent;

  const factory ChangeLogEvent.loadAll({
    required Iterable<Package> packages,
  }) = _LoadAllChangeLogEvent;
}
