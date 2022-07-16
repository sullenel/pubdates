import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/features/opened_projects/models/opened_project_entry.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on OpenedProjectEntry {
  File get iconFile => File(iconPath!);
}

class ProjectIcon extends StatelessWidget {
  const ProjectIcon({
    super.key,
    required this.entry,
    this.size = 32,
  });

  final OpenedProjectEntry entry;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (entry.iconPath == null) {
      return FlutterLogo(size: size);
    }

    return ClipRRect(
      borderRadius: AppBorders.button,
      child: Image.file(
        entry.iconFile,
        width: size,
        height: size,
        semanticLabel: AppLocalizations.of(context).projectLogoTooltip,
        errorBuilder: (_, __, ___) => FlutterLogo(size: size),
      ),
    );
  }
}
