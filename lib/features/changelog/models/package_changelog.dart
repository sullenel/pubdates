import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/changelog/models/changelog_content.dart';
import 'package:pubdates/features/project/models/package.dart';

part 'package_changelog.freezed.dart';

@freezed
class PackageChangeLog with _$PackageChangeLog {
  const PackageChangeLog._();

  const factory PackageChangeLog({
    required Package package,
    required List<ChangeLogContent> logs,
  }) = _PackageChangeLog;

  Iterable<ChangeLogContent> get logsTillCurrentVersion {
    return logs.takeWhile((it) => it.version != package.version);
  }
}
