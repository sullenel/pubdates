import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/widgets/space.dart';

class NoResult extends StatelessWidget {
  const NoResult({
    Key? key,
    required this.title,
    this.subtitle,
    this.child,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          if (subtitle != null) ...[
            const VSpace(AppInsets.md),
            Flexible(
              child: Text(
                subtitle!,
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if (child != null) ...[
            const VSpace(AppInsets.lg),
            Center(child: child),
          ],
        ],
      ),
    );
  }
}
