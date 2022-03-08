import 'package:http/http.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/services/changelog_parser.dart';
import 'package:pubdates/features/project/models/package.dart';

mixin ChangeLogProvider {
  Future<PackageChangeLog> changeLogForPackage(Package package);
}

class RemoteChangeLogProvider implements ChangeLogProvider {
  const RemoteChangeLogProvider({
    required Client client,
    required ChangeLogParser parser,
  })  : _client = client,
        _parser = parser;

  final Client _client;
  final ChangeLogParser _parser;

  @override
  Future<PackageChangeLog> changeLogForPackage(Package package) async {
    final response = await _client.get(package.changeLogUrl);
    final logs = _parser.parse(response.body);
    return PackageChangeLog(package: package, logs: logs);
  }
}
