import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/project/models/package.dart';

extension on Package {
  String get upgradePath {
    final currentVersion = version ?? '-';

    return canBeUpgraded
        ? '$currentVersion 🠖 ${update?.upgradableVersion}'
        : currentVersion;
  }
}

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
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.md,
        horizontal: AppInsets.lg,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppBorders.button,
            color: Colors.black.withOpacity(0.2),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppInsets.md,
            horizontal: AppInsets.lg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        package.name,
                        style: textTheme.titleMedium?.copyWith(
                          color: colors.onSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppInsets.md),
                    Flexible(
                      child: Text(
                        package.upgradePath,
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.onSecondary.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (package.canBeUpgraded) ...const [
                HSpace(AppInsets.md),
                Icon(AppIcons.circle, color: Colors.orange, size: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
