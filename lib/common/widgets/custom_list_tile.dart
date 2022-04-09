import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/widgets/space.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.onPressed,
    this.borderRadius = AppBorders.button,
    this.backgroundColor,
    this.padding,
    this.leading,
    this.trailing,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: AppBorders.button,
          color: backgroundColor,
        ),
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppInsets.md,
              horizontal: AppInsets.lg,
            ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const HSpace(AppInsets.lg),
            ],
            Expanded(child: child),
            if (trailing != null) ...[
              const HSpace(AppInsets.lg),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
