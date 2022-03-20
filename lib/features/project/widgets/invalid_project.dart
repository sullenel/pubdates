import 'package:flutter/material.dart';
import 'package:pubdates/common/widgets/no_result.dart';
import 'package:pubdates/localization/app_localizations.dart';

class InvalidProject extends StatelessWidget {
  const InvalidProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoResult(title: AppLocalizations.of(context).invalidProject);
  }
}
