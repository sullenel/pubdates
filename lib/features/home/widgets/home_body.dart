import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/shortcuts.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/home/widgets/app_logo.dart';
import 'package:pubdates/features/project/project_page.dart';
import 'package:pubdates/localization/app_localizations.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void _handleSelectProject() async {
    final path = await context.read<PathPicker>().selectDirectory();

    if (path != null) {
      Navigator.of(context).push(ProjectPage.route(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // No need for FocusableActionDetector for now
    return CallbackShortcuts(
      bindings: {
        AppShortcuts.open: _handleSelectProject,
      },
      child: Focus(
        autofocus: true,
        child: ColoredBox(
          color: colors.secondary,
          child: Padding(
            padding: const EdgeInsets.all(AppInsets.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: AppLogo()),
                const VSpace(AppInsets.lg),
                Center(
                  child: _SelectProjectAction(onPressed: _handleSelectProject),
                ),
              ],
            ),
          ),
        ),
      ),
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
