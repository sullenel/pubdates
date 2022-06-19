import 'package:flutter/material.dart';

@immutable
class HtmlTheme extends ThemeExtension<HtmlTheme> {
  const HtmlTheme({
    required this.linkColor,
    required this.codeColor,
  });

  final Color linkColor;
  final Color codeColor;

  @override
  ThemeExtension<HtmlTheme> copyWith({
    Color? linkColor,
    Color? codeColor,
  }) =>
      HtmlTheme(
        linkColor: linkColor ?? this.linkColor,
        codeColor: codeColor ?? this.codeColor,
      );

  @override
  ThemeExtension<HtmlTheme> lerp(ThemeExtension<HtmlTheme>? other, double t) {
    if (other is! HtmlTheme) {
      return this;
    }

    return HtmlTheme(
      linkColor: Color.lerp(linkColor, other.linkColor, t)!,
      codeColor: Color.lerp(codeColor, other.codeColor, t)!,
    );
  }
}
