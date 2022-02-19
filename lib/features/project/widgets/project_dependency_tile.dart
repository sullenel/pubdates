import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/features/project/models/package.dart';

class ProjectDependencyTile extends StatelessWidget {
  const ProjectDependencyTile({
    Key? key,
    required this.package,
    this.onPressed,
  }) : super(key: key);

  final Package package;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.md,
          horizontal: AppInsets.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                package.name,
                style: theme.textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: AppInsets.md),
            Flexible(
              child: Text(package.version ?? '-'),
            ),
          ],
        ),
      ),
    );
  }
}
