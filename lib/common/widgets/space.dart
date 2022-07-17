import 'package:flutter/cupertino.dart';
import 'package:pubdates/common/constants/dimensions.dart';

// ignore: constant_identifier_names
const Nothing = SizedBox.shrink();

class HSpace extends SizedBox {
  const HSpace(double width, {super.key}) : super(width: width);

  const HSpace.large({Key? key}) : this(AppInsets.lg, key: key);
  const HSpace.medium({Key? key}) : this(AppInsets.md, key: key);
  const HSpace.small({Key? key}) : this(AppInsets.sm, key: key);
}

class VSpace extends SizedBox {
  const VSpace(double height, {super.key}) : super(height: height);

  const VSpace.large({Key? key}) : this(AppInsets.lg, key: key);
  const VSpace.medium({Key? key}) : this(AppInsets.md, key: key);
  const VSpace.small({Key? key}) : this(AppInsets.sm, key: key);
}
