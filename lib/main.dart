import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/assets.dart';
import 'package:pubdates/common/constants/constants.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pubdates/app.dart';
import 'package:pubdates/common/persistence/local_storage.dart';
import 'package:pubdates/common/persistence/window_settings.dart';
import 'package:pubdates/common/utils/window_utils.dart';

void main() async {
  addLicense(AppAssets.fontLicense);
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final storage = LocalStorage(preferences: preferences);

  // Window set up
  final windowSettings = WindowSettings(storage: storage);
  final windowManager = await WindowManager.create(settings: windowSettings);

  runApp(
    App(
      storage: storage,
      windowManager: windowManager,
    ),
  );
}
