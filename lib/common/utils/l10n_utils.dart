import 'package:pubdates/common/models/errors.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension LocalizationExtension on AppLocalizations {
  String errorMessage(AppException error) {
    return error.map(
      pubNotFound: (_) => errorPubNotFound,
      invalidProject: (_) => errorInvalidProject,
      invalidPubspec: (state) => errorInvalidPubspec(state.path),
      pubspecNotFound: (state) => errorInvalidPubspec(state.path),
      projectNotFound: (_) => errorProjectNotFound,
      unknown: (state) => errorUnknown('${state.originalError}'),
    );
  }
}
