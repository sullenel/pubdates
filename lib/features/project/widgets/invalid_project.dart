import 'package:flutter/material.dart';
import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/common/utils/l10n_utils.dart';
import 'package:pubdates/common/widgets/no_result.dart';
import 'package:pubdates/localization/app_localizations.dart';

class InvalidProject extends StatelessWidget {
  const InvalidProject({
    Key? key,
    required this.error,
  }) : super(key: key);

  final AppException error;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final title = t.errorMessage(error);
    final action = error.maybeMap(
      orElse: () => TextButton(
        onPressed: Navigator.of(context).pop,
        child: Text(t.closeAction),
      ),
    );

    return NoResult(
      title: title,
      child: action,
    );
  }
}
