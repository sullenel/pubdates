import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: _handleSelectProject,
            child: Text(AppLocalizations.of(context).selectProjectAction),
          ),
        ),
      ],
    );
  }
}
