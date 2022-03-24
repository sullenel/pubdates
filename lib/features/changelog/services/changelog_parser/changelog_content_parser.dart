import 'package:html/dom.dart';
import 'package:pubdates/features/changelog/models/changelog_content.dart';

final _cleanVersionRegExp = RegExp(r'[\[\]#]');

// Versions may contain useless things like release date, text, etc.
String _cleanVersion(String value) {
  final cleaned = value.replaceAll(_cleanVersionRegExp, '').trim();
  final parts = cleaned.split(' - ');
  return parts.first.trim();
}

// TODO: add tests (hopefully)

// Let's over-engineer this shit and go full enterprise.
abstract class ChangeLogContentParser {
  ChangeLogContentParser? get nextParser;

  List<ChangeLogContent> parse(Document document);
}

// Changelog examples:
// - https://pub.dev/packages/dio/changelog
// - https://pub.dev/packages/bloc/changelog
class DefaultChangeLogContentParser implements ChangeLogContentParser {
  const DefaultChangeLogContentParser({this.nextParser});

  @override
  final ChangeLogContentParser? nextParser;

  @override
  List<ChangeLogContent> parse(Document document) {
    final result = document
        .querySelectorAll('.changelog-entry')
        .map(_parseEntry)
        .whereType<ChangeLogContent>()
        .toList(growable: false);

    if (result.isEmpty && nextParser != null) {
      return nextParser!.parse(document);
    }

    return result;
  }

  ChangeLogContent? _parseEntry(Element el) {
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
}

// Changelog examples:
// - https://pub.dev/packages/smooth_page_indicator/changelog
class AlternativeChangeLogContentParser implements ChangeLogContentParser {
  const AlternativeChangeLogContentParser({this.nextParser});

  @override
  final ChangeLogContentParser? nextParser;

  @override
  List<ChangeLogContent> parse(Document document) {
    final el = document.querySelector('.detail-tab-changelog-content');

    if (el == null) {
      return const <ChangeLogContent>[];
    }

    final result = el.children
        .where(_isChangeLogEntry)
        .map(_parseEntry)
        .whereType<ChangeLogContent>()
        .toList(growable: false);

    if (result.isEmpty && nextParser != null) {
      return nextParser!.parse(document);
    }

    return result;
  }

  // Changelog entries are structured as H2-tags directly followed by UL-tags.
  bool _isChangeLogEntry(Element el) {
    return el.localName == 'h2' && el.classes.contains('hash-header');
  }

  ChangeLogContent? _parseEntry(Element el) {
    final version = el.text.trim();
    final content = _parseContent(el);

    if (version.isEmpty || content == null) {
      return null;
    }

    return ChangeLogContent(
      version: _cleanVersion(version),
      content: content,
    );
  }

  String? _parseContent(Element el) {
    var nextEl = el.nextElementSibling;

    // Changelog example: https://pub.dev/packages/google_fonts/changelog
    if (nextEl?.localName == 'h3') {
      nextEl = nextEl?.nextElementSibling;
    }

    return nextEl?.localName == 'ul' ? nextEl?.outerHtml.trim() : null;
  }
}
