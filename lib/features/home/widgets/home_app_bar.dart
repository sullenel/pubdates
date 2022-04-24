import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/features/settings/widgets/settings_dialog.dart';
import 'package:pubdates/localization/app_localizations.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  void _handleOpenSettings() {
    const SettingsDialog().asDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AppBar(
      actions: [
        IconButton(
          onPressed: _handleOpenSettings,
          tooltip: t.settingsTitle,
          icon: const Icon(AppIcons.settings),
        ),
      ],
    );
  }
}
