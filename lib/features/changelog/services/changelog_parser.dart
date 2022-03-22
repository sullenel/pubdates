import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubdates/features/changelog/models/changelog_content.dart';

extension on List<ChangeLogContent> {
  // In some package changelogs, versions are specified in ascending order.
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
  const ChangeLogParser();

  List<ChangeLogContent> parse(String content) {
    final document = html.parse(content);

    return document
        .querySelectorAll('.changelog-entry')
        .map(_parseEntry)
        .whereType<ChangeLogContent>()
        .toList();
  }

  ChangeLogContent? _parseEntry(dom.Element el) {
    final version = el.querySelector('.changelog-version')?.text;
    final content = el.querySelector('.changelog-content')?.innerHtml.trim();

    if (version == null || content == null) {
      return null;
    }

    return ChangeLogContent(
      version: _cleanVersion(version),
      content: content,
    );
  }

  String _cleanVersion(String value) {
    return value.replaceAll('#', '').trim();
  }
}
