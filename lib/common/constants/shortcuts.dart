import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

abstract class AppShortcuts {
  // TODO: test on macOS
  static const open = SingleActivator(LogicalKeyboardKey.keyO, control: true);
  static const close = SingleActivator(LogicalKeyboardKey.keyW, control: true);
  static const settings =
      SingleActivator(LogicalKeyboardKey.comma, control: true);
}
