import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/localization/app_localizations.dart';

class ProjectNotSelected extends StatelessWidget {
  const ProjectNotSelected({
    Key? key,
    this.onSelect,
  }) : super(key: key);

  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.projectNotSelect,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppInsets.lg),
        TextButton(
          onPressed: onSelect,
          child: Text(t.selectAction),
        ),
      ],
    );
  }
}
