import 'package:flutter/cupertino.dart';

abstract class AppInsets {
  static const sm = 4.0;
  static const md = 8.0;
  static const lg = 16.0;
}

abstract class AppBorders {
  static const button = BorderRadius.all(Radius.circular(6));
  static const card = BorderRadius.all(Radius.circular(6));
}
