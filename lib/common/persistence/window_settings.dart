import 'dart:ui';

import 'package:pubdates/common/persistence/key_value_store.dart';

class WindowSettings {
  static String get _prefix => 'window';
  static String get _widthKey => '$_prefix.width';
  static String get _heightKey => '$_prefix.height';
  static String get _xPositionKey => '$_prefix.dx';
  static String get _yPositionKey => '$_prefix.dy';

  const WindowSettings({
    required KeyValueStore storage,
  }) : _storage = storage;

  final KeyValueStore _storage;

  Future<Size?> get size async {
    final width = await _storage.getDouble(_widthKey);
    final height = await _storage.getDouble(_heightKey);
    return width == null || height == null ? null : Size(width, height);
  }

  Future<void> saveSize(Size newSize) async {
    await _storage.putDouble(_widthKey, newSize.width);
    await _storage.putDouble(_heightKey, newSize.height);
  }

  Future<Offset?> get position async {
    final x = await _storage.getDouble(_xPositionKey);
    final y = await _storage.getDouble(_yPositionKey);
    return x == null || y == null ? null : Offset(x, y);
  }

  Future<void> savePosition(Offset newPosition) async {
    await _storage.putDouble(_xPositionKey, newPosition.dx);
    await _storage.putDouble(_yPositionKey, newPosition.dy);
  }
}
