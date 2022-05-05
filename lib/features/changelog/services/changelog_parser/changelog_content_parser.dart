import 'package:html/dom.dart';
import 'package:pubdates/common/utils/iterable_utils.dart';
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
        .toFixedList();

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
// - https://pub.dev/packages/google_fonts/changelog
// - https://pub.dev/packages/cached_network_image/changelog
class AlternativeChangeLogContentParser implements ChangeLogContentParser {
  static const _changeLogStartClass = 'hash-header';

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
        .where(_isStartOfChangeLogEntry)
        .map(_parseEntry)
        .whereType<ChangeLogContent>()
        .toFixedList();

    if (result.isEmpty && nextParser != null) {
      return nextParser!.parse(document);
    }

    return result;
  }

  // A changelog entry starts as a H2-tag directly followed by other tags.
  bool _isStartOfChangeLogEntry(Element el) {
    return el.localName == 'h2' && el.classes.contains(_changeLogStartClass);
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
    final elements = _findContentElements(el).toFixedList();

    if (elements.isEmpty) {
      return null;
    }

    final outputContainer = Element.tag('div');
    for (final node in elements) {
      outputContainer.append(node);
    }

    return outputContainer.outerHtml.trim();
  }

  // Finds all the elements between two H2 tags with the class of [_changeLogStartClass]
  Iterable<Element> _findContentElements(Element root) sync* {
    Element? el = root.nextElementSibling;

    while (el != null && !_isStartOfChangeLogEntry(el)) {
      yield el;
      el = el.nextElementSibling;
    }
  }
}
