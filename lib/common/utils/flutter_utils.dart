import 'dart:ui';

extension ColorExtension on Color {
  // Source: https://stackoverflow.com/q/55147586
  String toHex({bool withLeadingHash = true}) {
    final leading = withLeadingHash ? '#' : '';
    final value =
        (this.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();

    return '$leading$value';
  }
}
