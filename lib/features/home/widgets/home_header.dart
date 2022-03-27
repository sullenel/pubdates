import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/home/widgets/app_logo.dart';
import 'package:pubdates/localization/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    this.onSelectPressed,
  }) : super(key: key);

  final VoidCallback? onSelectPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppLogo(),
        const VSpace(AppInsets.lg),
        _SelectProjectAction(onPressed: onSelectPressed),
      ],
    );
  }
}

class _SelectProjectAction extends StatelessWidget {
  const _SelectProjectAction({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(AppInsets.lg * 1.5),
        side: BorderSide(
          color: colors.onSecondary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        AppLocalizations.of(context).selectProjectAction,
        style: theme.textTheme.titleLarge?.copyWith(
          height: 1,
          fontWeight: FontWeight.normal,
          color: colors.onSecondary.withOpacity(0.5),
        ),
      ),
    );
  }
}
