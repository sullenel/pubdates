import 'package:flutter/material.dart';
import 'package:pubdates/common/widgets/no_result.dart';
import 'package:pubdates/localization/app_localizations.dart';

class ProjectHasNoDependencies extends StatelessWidget {
  const ProjectHasNoDependencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoResult(title: AppLocalizations.of(context).projectNoDependencies);
  }
}
