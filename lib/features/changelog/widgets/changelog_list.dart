import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/typedefs.dart';
import 'package:pubdates/common/utils/url_utils.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/features/changelog/bloc/changelog_bloc.dart';
import 'package:pubdates/features/changelog/bloc/changelog_state.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/widgets/changelog_summary.dart';

class ChangeLogList extends StatefulWidget {
  const ChangeLogList({Key? key}) : super(key: key);

  @override
  State<ChangeLogList> createState() => _ChangeLogListState();
}

class _ChangeLogListState extends State<ChangeLogList> {
  void _handleUrl(String url) async {
    try {
      await context.read<UrlOpener>().openUrl(url);
    } on Exception {
      // TODO: show snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLogBloc, ChangeLogState>(
      builder: (context, state) {
        return state.map(
          waitingForPackages: (_) => const LoadingIndicator(),
          loading: (state) => _ChangeLogList(
            onLinkPressed: _handleUrl,
            logs: state.loaded,
          ),
          loaded: (state) => _ChangeLogList(
            onLinkPressed: _handleUrl,
            logs: state.loaded,
          ),
        );
      },
    );
  }
}

class _ChangeLogList extends StatelessWidget {
  const _ChangeLogList({
    Key? key,
    required this.logs,
    this.onLinkPressed,
  }) : super(key: key);

  final List<PackageChangeLog> logs;
  final LinkCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppInsets.md),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final item = logs[index];

          return ChangeLogSummary(
            changeLog: item,
            onLinkPressed: onLinkPressed,
            onOpenPressed: onLinkPressed == null
                ? null
                : () => onLinkPressed!(item.package.changeLogUrl.toString()),
          );
        },
      ),
    );
  }
}
