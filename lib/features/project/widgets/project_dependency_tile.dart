import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/themes.dart';
import 'package:pubdates/common/widgets/custom_list_tile.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.md,
        horizontal: AppInsets.lg,
      ),
      child: CustomListTile(
        onPressed: onPressed,
        trailing: package.canBeUpgraded
            ? const Icon(AppIcons.circle, color: AppColors.update, size: 10)
            : null,
        child: _PackageInfoSection(package: package),
      ),
    );
  }
}

class _PackageInfoSection extends StatelessWidget {
  const _PackageInfoSection({
    Key? key,
    required this.package,
  }) : super(key: key);

  final Package package;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textColor = theme.customListTileForegroundColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            package.name,
            style: textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const VSpace(AppInsets.md),
        Flexible(
          child: Text(
            package.upgradePath,
            style: textTheme.bodySmall?.copyWith(
              color: textColor.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
