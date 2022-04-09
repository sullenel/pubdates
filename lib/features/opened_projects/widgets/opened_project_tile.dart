import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/widgets/custom_list_tile.dart';
import 'package:pubdates/common/widgets/flip_on_hover.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/features/opened_projects/widgets/project_icon.dart';

class OpenedProjectTile extends StatelessWidget {
  const OpenedProjectTile({
    Key? key,
    required this.entry,
    this.onPressed,
    this.onDelete,
  }) : super(key: key);

  final OpenedProjectEntry entry;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final frontIcon = Icon(
      AppIcons.arrowRight,
      color: colors.onSecondary.withOpacity(0.5),
    );

    return CustomListTile(
      onPressed: onPressed,
      // FIXME: get the color from the theme
      backgroundColor: Colors.black.withOpacity(0.2),
      leading: ProjectIcon(entry: entry),
      trailing: FlipOnHover(
        front: frontIcon,
        // NOTE: in case we need to (temporarily) disable the delete action
        back: onDelete == null
            ? frontIcon
            : GestureDetector(
                onTap: onDelete,
                child: Icon(
                  AppIcons.remove,
                  color: colors.onSecondary.withOpacity(0.5),
                ),
              ),
      ),
      child: _ProjectInfoSection(
        title: entry.name,
        subtitle: entry.fullPath,
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
