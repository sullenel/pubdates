import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const borderRadius = AppBorders.dialog;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppInsets.lg),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),
    );
  }
}
