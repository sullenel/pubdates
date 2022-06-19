import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pubdates/common/utils/platform_utils.dart';

SingleActivator _controlActivator(LogicalKeyboardKey key) => SingleActivator(
      key,
      control: !isMacOS,
      meta: isMacOS,
    );

mixin AppShortcuts {
  static final open = _controlActivator(LogicalKeyboardKey.keyO);
  static final close = _controlActivator(LogicalKeyboardKey.keyW);
  static final settings = _controlActivator(LogicalKeyboardKey.comma);
}
