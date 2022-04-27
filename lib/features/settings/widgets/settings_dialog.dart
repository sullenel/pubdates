import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/common/widgets/dialog_title.dart';
import 'package:pubdates/common/widgets/limited_width.dart';
import 'package:pubdates/features/project/models/package_sorting.dart';
import 'package:pubdates/features/settings/bloc/settings_bloc.dart';
import 'package:pubdates/localization/app_localizations.dart';

part 'sdk_path_option.dart';
part 'package_sorting_option.dart';
part 'theme_mode_option.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return LimitedWidth(
      maxWidth: 600,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogTitle(
              title: AppLocalizations.of(context).settingsTitle,
            ),
            const Divider(
              height: 0,
              indent: AppInsets.lg,
              endIndent: AppInsets.lg,
            ),
            const Flexible(
              child: _SettingsBody(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        _ThemeModeOption(),
        _PackageSortingOption(),
        _SdkPathOption(),
      ],
    );
  }
}
