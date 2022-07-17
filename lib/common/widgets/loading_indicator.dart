import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/platform_utils.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/localization/app_localizations.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isMacOS
          ? const _AppleLoadingIndicator()
          : const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
    );
  }
}

class _AppleLoadingIndicator extends StatelessWidget {
  const _AppleLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(),
        const VSpace.small(),
        Text(
          AppLocalizations.of(context).loading,
          style: textTheme.caption,
        ),
      ],
    );
  }
}

class LinearLoadingIndicator extends StatelessWidget {
  const LinearLoadingIndicator({
    Key? key,
    this.value,
  }) : super(key: key);

  final double? value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}
