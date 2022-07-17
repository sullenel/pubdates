import 'package:flutter/material.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';

// FIXME: create a better logo than this lame-ass one
class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = context.colorScheme;
    final textStyle = theme.textTheme.headlineLarge?.copyWith(
      color: colors.onSecondary,
      fontWeight: FontWeight.bold,
      fontSize: 48,
      height: 1,
    );

    return Row(
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
              color: colors.onSecondary.withOpacity(0.25),
            ),
          ),
        ),
      ],
    );
  }
}
