import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';

ThemeData get lightTheme {
  const colorScheme = ColorScheme.light(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color(0xFF1C2833),
    onSecondary: Colors.white,
    surface: Colors.white,
    shadow: Colors.black26,
    background: Color(0xFFF5F5F5),
  );

  final appBarTheme = AppBarTheme(
    backgroundColor: colorScheme.secondary,
    foregroundColor: colorScheme.onSecondary,
    centerTitle: true,
    elevation: 0,
  );

  final cardTheme = CardTheme(
    color: colorScheme.surface,
    shadowColor: colorScheme.shadow,
    elevation: 4,
    margin: const EdgeInsets.symmetric(
      horizontal: AppInsets.lg,
      vertical: AppInsets.md,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorders.card,
    ),
  );

  const dividerTheme = DividerThemeData(
    thickness: 0,
    color: Colors.black12,
  );

  const scrollBarTheme = const ScrollbarThemeData();

  final progressIndicatorTheme = ProgressIndicatorThemeData(
    linearMinHeight: 4,
    color: colorScheme.secondary,
    circularTrackColor: AppColors.transparent,
    linearTrackColor: AppColors.transparent,
  );

  final textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
    ),
  );

  return ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
    dividerTheme: dividerTheme,
    scrollbarTheme: scrollBarTheme,
    splashColor: Colors.black26,
    highlightColor: Colors.black12,
    progressIndicatorTheme: progressIndicatorTheme,
    textButtonTheme: textButtonTheme,
  );
}

ThemeData get darkTheme {
  const colorScheme = const ColorScheme.dark();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
