import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
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
