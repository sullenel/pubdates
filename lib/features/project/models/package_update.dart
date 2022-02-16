import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_update.freezed.dart';
part 'package_update.g.dart';

@freezed
class PackageUpdate with _$PackageUpdate {
  const PackageUpdate._();

  // NOTE: the currentVersion and upgradableVersion are null when pubspec.lock is
  // missing. Not sure about the others.
  const factory PackageUpdate({
    required String name,
    String? currentVersion,
    String? upgradableVersion,
    String? resolvableVersion,
    String? latestVersion,
  }) = _PackageUpdate;

  factory PackageUpdate.fromJson(Map<String, dynamic> json) =>
      _$PackageUpdateFromJson(json);
}
