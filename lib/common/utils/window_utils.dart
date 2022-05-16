import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/constants.dart';
import 'package:pubdates/common/persistence/window_settings.dart';
import 'package:pubdates/common/utils/platform_utils.dart';
import 'package:window_manager/window_manager.dart';

// "A codebase without a manager class is nothing to boast about." - Anonymous Enterprise Developer
mixin WindowManager {
  static Future<WindowManager> create({
    required WindowSettings settings,
  }) async {
    if (!kIsDesktop) {
      return const DefaultWindowManager()..configure();
    }

    final wm = DesktopWindowManager(settings: settings);
    await wm.configure();
    return wm;
  }

  Future<void> configure() async {}

  Future<void> updateTitle(final String newTitle) async {}

  Future<void> restoreTitle() async {}

  Future<void> dispose() async {}
}

// A noop implementation
class DefaultWindowManager with WindowManager {
  const DefaultWindowManager();
}

class DesktopWindowManager with WindowListener implements WindowManager {
  static const _minimumSize = Size(480, 640);
  static const _defaultSize = Size(1200, 800);

  const DesktopWindowManager({
    required WindowSettings settings,
    String title = AppConstants.appName,
  })  : _settings = settings,
        _title = title;

  final WindowSettings _settings;
  final String _title;

  @override
  Future<void> configure() async {
    final size = await _settings.size ?? _defaultSize;
    final position = await _settings.position;
    final isCentered = position == null;
    final options = WindowOptions(
      minimumSize: _minimumSize,
      size: size,
      center: isCentered,
      title: _title,
    );

    await windowManager.ensureInitialized();

    if (position != null) {
      await windowManager.setPosition(position);
    }

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    windowManager.addListener(this);
  }

  @override
  Future<void> updateTitle(final String newTitle) async {
    if (newTitle != _title) {
      await windowManager.setTitle(_formatTitle(newTitle));
    }
  }

  @override
  Future<void> restoreTitle() {
    return windowManager.setTitle(_title);
  }

  @override
  Future<void> dispose() async {
    windowManager.removeListener(this);
  }

  // Private
  String _formatTitle(String text) {
    return '$text - $_title';
  }

  Future<void> _savePosition() async {
    final position = await windowManager.getPosition();
    return _settings.savePosition(position);
  }

  Future<void> _saveSize() async {
    final size = await windowManager.getSize();
    return _settings.saveSize(size);
  }

  // Overrides
  @override
  void onWindowResized() {
    _saveSize();
    _savePosition();
  }

  @override
  void onWindowMoved() {
    _savePosition();
  }

  @override
  void onWindowMaximize() {
    _saveSize();
  }

  @override
  void onWindowUnmaximize() {
    _saveSize();
  }
}
