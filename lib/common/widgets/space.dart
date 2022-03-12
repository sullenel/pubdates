import 'package:flutter/cupertino.dart';

// ignore: constant_identifier_names
const Nothing = SizedBox.shrink();

class HSpace extends SizedBox {
  const HSpace(double width, {Key? key}) : super(key: key, width: width);
}

class VSpace extends SizedBox {
  const VSpace(double height, {Key? key}) : super(key: key, height: height);
}
