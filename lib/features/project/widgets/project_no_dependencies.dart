import 'package:flutter/material.dart';
import 'package:pubdates/localization/app_localizations.dart';

class ProjectHasNoDependencies extends StatelessWidget {
  const ProjectHasNoDependencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context).projectNoDependencies,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
