import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:pubdates/features/changelog/models/changelog_content.dart';

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
