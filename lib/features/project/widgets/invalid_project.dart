import 'package:flutter/material.dart';
import 'package:pubdates/localization/app_localizations.dart';

class InvalidProject extends StatelessWidget {
  const InvalidProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context).invalidProject),
    );
  }
}
