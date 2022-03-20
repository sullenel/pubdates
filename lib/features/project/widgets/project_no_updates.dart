import 'package:flutter/material.dart';
import 'package:pubdates/common/widgets/no_result.dart';
import 'package:pubdates/localization/app_localizations.dart';

class ProjectNoUpdates extends StatelessWidget {
  const ProjectNoUpdates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return NoResult(
      title: t.projectNoUpdates,
      child: TextButton(
        onPressed: Navigator.of(context).pop,
        child: Text(t.closeAction),
      ),
    );
  }
}
