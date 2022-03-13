import 'package:flutter/material.dart';
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

  const dividerTheme = const DividerThemeData(
    thickness: 0,
    color: Colors.black12,
  );

  const scrollBarTheme = const ScrollbarThemeData();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
    dividerTheme: dividerTheme,
    scrollbarTheme: scrollBarTheme,
    splashColor: Colors.black26,
    highlightColor: Colors.black12,
  );
}

ThemeData get darkTheme {
  const colorScheme = const ColorScheme.dark();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
