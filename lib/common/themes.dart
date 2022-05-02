import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';

class _ThemeBuilder {
  const _ThemeBuilder({
    required ColorScheme colors,
    TextTheme? textTheme,
    Color? borderColor,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    String? fontFamily,
  })  : _colors = colors,
        _textTheme = textTheme,
        _borderColor = borderColor,
        _splashColor = splashColor,
        _highlightColor = highlightColor,
        _hoverColor = hoverColor,
        _fontFamily = fontFamily;

  final ColorScheme _colors;
  final TextTheme? _textTheme;
  final Color? _borderColor;
  final Color? _splashColor;
  final Color? _highlightColor;
  final Color? _hoverColor;
  final String? _fontFamily;

  ThemeData toTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      textTheme: _textTheme,
      colorScheme: _colors,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dividerTheme: _dividerTheme,
      scrollbarTheme: _scrollBarTheme,
      splashColor: _splashColor,
      highlightColor: _highlightColor,
      progressIndicatorTheme: _progressIndicatorTheme,
      textButtonTheme: _textButtonTheme,
      scaffoldBackgroundColor: _colors.background,
      dialogTheme: _dialogTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      popupMenuTheme: _popupMenuTheme,
      listTileTheme: _listTileTheme,
      tooltipTheme: _tooltipTheme,

      // Legacy stuff
      hoverColor: _hoverColor,
      // Used for dropdown buttons
      canvasColor: _popupMenuTheme.color,
    );
  }

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: _colors.primary,
        foregroundColor: _colors.onPrimary,
        centerTitle: true,
        elevation: 0,
      );

  DividerThemeData get _dividerTheme => DividerThemeData(
        color: _borderColor,
      );

  CardTheme get _cardTheme => CardTheme(
        color: _colors.surface,
        shadowColor: _colors.shadow,
        clipBehavior: Clip.hardEdge,
        elevation: 6,
        margin: const EdgeInsets.symmetric(
          horizontal: AppInsets.lg,
          vertical: AppInsets.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.card,
          side: BorderSide(color: _borderColor!),
        ),
      );

  // The spec fails at explaining what these tertiaries and other shitaries they
  // came up with should be used for, so let's us it for the scrollbar for now. #yolo
  ScrollbarThemeData get _scrollBarTheme => ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(_colors.tertiary),
      );

  ProgressIndicatorThemeData get _progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        linearMinHeight: 6,
        color: _colors.primary,
        circularTrackColor: AppColors.transparent,
        linearTrackColor: AppColors.transparent,
      );

  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: _colors.secondary,
          primary: _colors.onSecondary,
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.button),
        ),
      );

  OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: _colors.onPrimaryContainer,
          backgroundColor: _colors.primaryContainer,
          side: BorderSide(color: _borderColor!),
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.button),
          textStyle: const TextStyle(
            // NOTE: otherwise the text is not vertically centered
            height: 1.1,
          ),
        ),
      );

  DialogTheme get _dialogTheme => DialogTheme(
        backgroundColor: _colors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: AppBorders.dialog,
        ),
      );

  PopupMenuThemeData get _popupMenuTheme => PopupMenuThemeData(
        color: _colors.primaryContainer,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.card,
          side: BorderSide(color: _borderColor!),
        ),
      );

  ListTileThemeData get _listTileTheme => ListTileThemeData(
        tileColor: _colors.primaryContainer,
        textColor: _colors.onPrimaryContainer,
        iconColor: _colors.onPrimaryContainer.withOpacity(0.5),
      );

  TooltipThemeData get _tooltipTheme => TooltipThemeData(
        padding: const EdgeInsets.all(AppInsets.md),
        textStyle: TextStyle(
          fontSize: 12,
          color: _colors.onPrimaryContainer,
        ),
        decoration: BoxDecoration(
          color: _colors.primaryContainer,
          borderRadius: AppBorders.button,
          border: Border.all(color: _borderColor!),
        ),
      );
}

// The colors are shamelessly stolen from Github themes.
ThemeData get lightTheme => const _ThemeBuilder(
      colors: ColorScheme.light(
        primary: Color(0xFF24292F),
        onPrimary: Colors.white,
        primaryContainer: Colors.white,
        onPrimaryContainer: Color(0xFF24292F),
        secondary: Color(0xFF2c974b),
        onSecondary: Colors.white,
        secondaryContainer: Color.fromRGBO(0, 0, 0, 0.2),
        onSecondaryContainer: Colors.white,
        tertiary: Colors.black38,
        background: Color(0xFFF6F8FA),
        onBackground: Color(0xFF57606a),
        surface: Colors.white,
        onSurface: Color(0xFF24292F),
        shadow: Color.fromRGBO(140, 149, 159, 0.15),
        error: Color(0xFFCF222E),
        onError: Colors.white,
      ),
      borderColor: Color(0xFFD8DEE4),
      splashColor: Colors.black26,
      highlightColor: Colors.black12,
      hoverColor: Colors.black12,
    ).toTheme();

ThemeData get darkTheme => const _ThemeBuilder(
      colors: ColorScheme.dark(
        primary: Color(0xFF2D333B),
        onPrimary: Color(0xFFcdd9e5),
        primaryContainer: Color(0xFF2D333B),
        onPrimaryContainer: Color(0xFFadbac7),
        secondary: Color(0xFF347d39),
        onSecondary: Colors.white,
        secondaryContainer: Color.fromRGBO(0, 0, 0, 0.2),
        onSecondaryContainer: Colors.white,
        tertiary: Color(0xFF373e47),
        background: Color(0xFF1C2128),
        onBackground: Color(0xFF768390),
        surface: Color(0xFF22272E),
        onSurface: Color(0xFFadbac7),
        shadow: Colors.transparent,
        error: Color(0xFFE5534B),
        onError: Color(0xFFCDD9E5),
      ),
      borderColor: Color(0xFF373e47),
      splashColor: Colors.black26,
      highlightColor: Colors.black12,
      hoverColor: Colors.black12,
    ).toTheme();

// TODO: use the new ThemeExtension once it is in stable
extension ThemeExtension on ThemeData {
  Color get customListTileBackgroundColor => colorScheme.secondaryContainer;
  Color get customListTileForegroundColor => colorScheme.onSecondaryContainer;

  // For HTML tags
  bool get _isInDarkMode => brightness == Brightness.dark;
  Color get linkColor =>
      _isInDarkMode ? const Color(0xFF539BF5) : const Color(0xFF0969da);
  Color get codeColor =>
      _isInDarkMode ? const Color(0xFF373E47) : const Color(0xFFf6f8fa);
}
