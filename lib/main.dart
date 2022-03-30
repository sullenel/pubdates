import 'package:flutter/material.dart';
import 'package:pubdates/app.dart';
import 'package:pubdates/common/persistence/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final storage = LocalStorage(preferences: preferences);

  runApp(App(storage: storage));
}
