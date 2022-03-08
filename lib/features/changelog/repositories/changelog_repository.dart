import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/services/changelog_provider.dart';
import 'package:pubdates/features/project/models/package.dart';

class ChangeLogRepository {
  const ChangeLogRepository({
    required RemoteChangeLogProvider remoteChangeLogProvider,
  }) : _remoteChangeLogProvider = remoteChangeLogProvider;

  final ChangeLogProvider _remoteChangeLogProvider;

  Future<PackageChangeLog> changeLogForPackage(Package package) {
    return _remoteChangeLogProvider.changeLogForPackage(package);
  }
}
