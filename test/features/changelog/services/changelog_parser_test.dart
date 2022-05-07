import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' show join;
import 'package:pubdates/features/changelog/services/changelog_parser.dart';
import 'package:pubdates/features/changelog/services/changelog_parser/changelog_content_parser.dart';

const _fixturesPath = 'test/features/changelog/services/fixtures/';

Future<String> _contentsOf(String fileName, {String extension = 'html'}) {
  final file = File(join(_fixturesPath, '$fileName.$extension'));
  return file.readAsString();
}

void main() {
  group('AlternativeChangeLogContentParser', () {
    const parser = ChangeLogParser(parser: AlternativeChangeLogContentParser());
    final entryPattern = RegExp(r'<li>.*<\/li>');
    final subsectionPattern = RegExp(r'<h3 class="hash-header"');

    group('Parsing changelogs with subsections', () {
      test('should parse a changelog with a subsection', () async {
        final content = await _contentsOf('alternative_changelog_subsection');
        final actual = parser.parse(content);
        final logs = actual.first.content;

        expect(actual, hasLength(1));
        expect(entryPattern.allMatches(logs), hasLength(3));
        expect(subsectionPattern.hasMatch(logs), isTrue);
        expect(subsectionPattern.allMatches(logs), hasLength(1));
      });

      test('should parse a changelog with multiple subsections', () async {
        final content =
            await _contentsOf('alternative_changelog_multi_subsections');
        final actual = parser.parse(content);
        final logs = actual.first.content;

        expect(actual, hasLength(1));
        expect(subsectionPattern.hasMatch(logs), isTrue);
        expect(subsectionPattern.allMatches(logs), hasLength(2));
      });
    });

    group('Parsing changelogs with no subsections', () {
      test('should parse a changelog with a subsection', () async {
        final content =
            await _contentsOf('alternative_changelog_no_subsections');
        final actual = parser.parse(content);
        final logs = actual.first.content;

        expect(actual, hasLength(1));
        expect(entryPattern.allMatches(logs), hasLength(5));
        expect(subsectionPattern.hasMatch(logs), isFalse);
      });
    });

    group('Parsing changelogs with mixed content', () {
      test('should parse a changelog with a subsection', () async {
        final content = await _contentsOf('alternative_changelog_multi_tags');
        final actual = parser.parse(content);
        final logs = actual.first.content;

        expect(actual, hasLength(1));
        expect(entryPattern.allMatches(logs), hasLength(2));
        expect(RegExp(r'<pre>').hasMatch(logs), isTrue);
      });
    });

    group('Parsing changelogs with no content', () {
      test('should skip a changelog with no content', () async {
        final content = await _contentsOf('alternative_changelog_no_content');
        final actual = parser.parse(content);
        expect(actual, isEmpty);
      });

      test('should skip changelogs with no content (multiple entries)',
          () async {
        final content =
            await _contentsOf('alternative_changelog_no_content_multi');
        final actual = parser.parse(content);
        expect(actual, hasLength(1));
        // Unsure it is okay to do it this way though
        expect(actual.first.version, equals('2.3.2'));
      });
    });
  });
}
