import 'package:html/parser.dart' as html;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubdates/features/changelog/models/changelog_content.dart';
import 'package:pubdates/features/changelog/services/changelog_parser/changelog_content_parser.dart';

extension on List<ChangeLogContent> {
  // In some changelogs, versions are specified in ascending order. Examples:
  // - https://pub.dev/packages/google_ml_vision/changelog
  List<ChangeLogContent> get sortedInDescendingOrder {
    if (_isInDescendingOrder) {
      return this;
    }

    return this..sort(_compareVersionsInDescendingOrder);
  }

  bool get _isInDescendingOrder {
    // It is more than enough.
    if (length > 1) {
      final current = Version.parse(this[0].version);
      final next = Version.parse(this[1].version);
      return current > next;
    }

    return true;
  }

  // As if a mad Swift developer bit me.
  int _compareVersionsInDescendingOrder(
    ChangeLogContent a,
    ChangeLogContent b,
  ) {
    return Version.parse(b.version).compareTo(Version.parse(a.version));
  }
}

class ChangeLogParser {
  static const ChangeLogContentParser defaultParser =
      DefaultChangeLogContentParser(
    nextParser: AlternativeChangeLogContentParser(),
  );

  const ChangeLogParser({
    ChangeLogContentParser parser = defaultParser,
  }) : _parser = parser;

  final ChangeLogContentParser _parser;

  List<ChangeLogContent> parse(String content) {
    final document = html.parse(content);
    return _parser.parse(document).sortedInDescendingOrder;
  }
}
