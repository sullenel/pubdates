import 'package:flutter/material.dart';
import 'package:pubdates/common/widgets/no_result.dart';
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

    return NoResult(
      title: t.projectNotSelect,
      child: TextButton(
        onPressed: onSelect,
        child: Text(t.selectAction),
      ),
    );
  }
}
