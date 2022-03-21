import 'package:flutter/material.dart';

abstract class Breakpoints {
  static const double smallScreen = 800;
  static const double mediumScreen = 1000;
  static const double largeScreen = 1200;
}

extension on BoxConstraints {
  bool get isSmallScreen => maxWidth <= Breakpoints.smallScreen;

  bool get isMediumScreen => maxWidth <= Breakpoints.mediumScreen;

  bool get isLargeScreen => maxWidth <= Breakpoints.largeScreen;
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.large,
    this.medium,
    this.child,
  }) : super(key: key);

  final TransitionBuilder small;
  final TransitionBuilder large;
  final TransitionBuilder? medium;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.isSmallScreen) {
          return small.call(context, child);
        }

        if (constraints.isMediumScreen) {
          return (medium ?? large).call(context, child);
        }

        return large.call(context, child);
      },
    );
  }
}
