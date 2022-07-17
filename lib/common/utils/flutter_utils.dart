import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pubdates/common/config/theme_extensions.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension ColorExtension on Color {
  // Source: https://stackoverflow.com/q/55147586
  String toHex({bool withLeadingHash = true}) {
    final leading = withLeadingHash ? '#' : '';
    final value =
        (this.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();

    return '$leading$value';
  }
}

extension BuildContextExtension on BuildContext {
  static const _snackBarDuration = Duration(seconds: 5);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  CustomColors get customColors => theme.extension<CustomColors>()!;

  AppLocalizations get tr => AppLocalizations.of(this);

  void showSnackBar(
    String message, {
    Duration duration = _snackBarDuration,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.all(AppInsets.lg),
      duration: duration,
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: theme.snackBarTheme.contentTextStyle?.copyWith(
          color: foregroundColor,
        ),
      ),
    );

    ScaffoldMessenger.maybeOf(this)
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showSuccessSnackBar(
    String message, {
    Duration duration = _snackBarDuration,
  }) =>
      showSnackBar(
        message,
        duration: duration,
        backgroundColor: customColors.success,
        foregroundColor: customColors.onSuccess,
      );

  void showErrorSnackBar(
    String message, {
    Duration duration = _snackBarDuration,
  }) =>
      showSnackBar(
        message,
        duration: duration,
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
      );
}

extension WidgetExtension on Widget {
  Future<T?> asDialog<T>(
    BuildContext context, {
    bool dismissible = true,
  }) {
    return showCupertinoDialog<T?>(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => this,
    );
  }
}

void addLicense(String filePath, {String? packageName}) {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(filePath);

    if (license.isNotEmpty) {
      yield LicenseEntryWithLineBreaks(
        [if (packageName != null) packageName],
        license,
      );
    }
  });
}
