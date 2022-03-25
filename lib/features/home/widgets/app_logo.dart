import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';

// FIXME: create a better logo than this lame-ass one
class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.headlineLarge?.copyWith(
      color: theme.colorScheme.onSecondary,
      fontWeight: FontWeight.bold,
      fontSize: 48,
      height: 1,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text('pub', style: textStyle),
            ),
            Flexible(
              child: Text(
                'dates',
                style: textStyle?.copyWith(
                  color: theme.colorScheme.onSecondary.withOpacity(0.25),
                ),
              ),
            ),
          ],
        ),
        const Positioned(
          top: -4,
          right: -16,
          child: UpgradeBadge(),
        ),
      ],
    );
  }
}

class UpgradeBadge extends StatelessWidget {
  const UpgradeBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppInsets.sm),
        child: Icon(AppIcons.upgrade, size: 12, color: Colors.white),
      ),
    );
  }
}
