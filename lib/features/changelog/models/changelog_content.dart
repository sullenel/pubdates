import 'package:freezed_annotation/freezed_annotation.dart';

part 'changelog_content.freezed.dart';

@freezed
class ChangeLogContent with _$ChangeLogContent {
  const factory ChangeLogContent({
    required String version,
    required String content,
  }) = _ChangeLogContent;
}
