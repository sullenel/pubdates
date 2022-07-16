import 'package:flutter/material.dart';

mixin AppInsets {
  static const sm = 4.0;
  static const md = 8.0;
  static const lg = 16.0;
}

mixin AppBorders {
  static const button = BorderRadius.all(Radius.circular(6));
  static const card = BorderRadius.all(Radius.circular(6));
  static const dialog = card;
}

mixin AppSizes {
  static const appBarHeight = kToolbarHeight;
}
