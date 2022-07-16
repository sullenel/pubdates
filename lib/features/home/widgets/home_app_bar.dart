import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/features/home/widgets/app_scope.dart';
import 'package:pubdates/localization/app_localizations.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AppBar(
      actions: [
        IconButton(
          onPressed: () => AppScope.openSettings(context),
          tooltip: t.settingsTitle,
          icon: const Icon(AppIcons.settings),
        ),
      ],
    );
  }
}
