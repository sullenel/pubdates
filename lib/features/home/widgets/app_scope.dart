import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/features/project/project_page.dart';
import 'package:pubdates/features/settings/widgets/settings_dialog.dart';

class AppScope extends StatelessWidget {
  const AppScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static void selectProject(BuildContext context) async {
    final path = await context.read<PathPicker>().selectDirectory();

    if (path != null) {
      openProject(context, path: path);
    }
  }

  static void openProject(
    BuildContext context, {
    required Directory path,
  }) {
    final currentRoute = ModalRoute.of(context)!;
    final nextRoute = ProjectPage.route(path);
    final navigator = Navigator.of(context);

    // FIXME: revise once https://github.com/sullenel/pubdates/issues/6 is done
    if (currentRoute.isCurrent) {
      navigator.push(nextRoute);
    } else {
      navigator.pushReplacement(nextRoute);
    }
  }

  static void openSettings(BuildContext context) {
    const SettingsDialog().asDialog(context);
  }

  @override
  Widget build(BuildContext context) => child;
}
