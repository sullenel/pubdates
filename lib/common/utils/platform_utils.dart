import 'package:flutter/foundation.dart';

const _desktopPlatforms = {
  TargetPlatform.windows,
  TargetPlatform.macOS,
  TargetPlatform.linux,
};

bool get kIsDesktop =>
    !kIsWeb && _desktopPlatforms.contains(defaultTargetPlatform);
