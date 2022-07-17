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

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.onSuccess,
    required this.info,
    required this.onInfo,
  });

  final Color success;
  final Color onSuccess;
  final Color info;
  final Color onInfo;

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? success,
    Color? onSuccess,
    Color? info,
    Color? onInfo,
  }) {
    return CustomColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}
