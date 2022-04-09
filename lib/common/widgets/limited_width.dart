import 'package:flutter/material.dart';

// Unsure if it is the right way to do it
class LimitedWidth extends StatelessWidget {
  const LimitedWidth({
    Key? key,
    required this.maxWidth,
    required this.child,
  }) : super(key: key);

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
