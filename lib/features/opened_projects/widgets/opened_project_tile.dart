import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/features/opened_projects/widgets/project_icon.dart';

// TODO: extract a reusable widget since its code is similar to ProjectDependencyTile
class OpenedProjectTile extends StatelessWidget {
  const OpenedProjectTile({
    Key? key,
    required this.entry,
    this.onPressed,
  }) : super(key: key);

  final OpenedProjectEntry entry;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: AppBorders.button,
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
            ProjectIcon(entry: entry),
            const HSpace(AppInsets.lg),
            Expanded(
              child: _ProjectInfoSection(
                title: entry.name,
                subtitle: entry.fullPath,
              ),
            ),
            const HSpace(AppInsets.lg),
            Icon(
              AppIcons.arrowRight,
              color: colors.onSecondary.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectInfoSection extends StatelessWidget {
  const _ProjectInfoSection({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: colors.onSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const VSpace(AppInsets.md),
        Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: colors.onSecondary.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
