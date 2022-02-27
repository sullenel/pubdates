import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubdates/features/project/models/package_update.dart';

part 'package.freezed.dart';

@freezed
class Package with _$Package {
  const Package._();

  const factory Package({
    required String name,
    String? version,
    String? url,
    PackageUpdate? update,
  }) = _Package;

  bool get canBeUpgraded {
    return update != null && version != update?.upgradableVersion;
  }
}
