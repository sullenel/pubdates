import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:pubdates/common/constants/dimensions.dart';
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
    // TODO: move out of here
    final path = await getDirectoryPath();

    if (path != null) {
      Navigator.of(context).push(ProjectPage.route(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return FractionallySizedBox(
      widthFactor: 1,
      child: ColoredBox(
        color: colors.secondary,
        child: Padding(
          padding: const EdgeInsets.all(AppInsets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              Padding(
                padding: const EdgeInsets.all(AppInsets.lg),
                child: OutlinedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(AppInsets.lg),
                    side: BorderSide(
                      color: colors.onSecondary.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  onPressed: _handleSelectProject,
                  child: Text(
                    AppLocalizations.of(context).selectProjectAction,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.onSecondary.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
