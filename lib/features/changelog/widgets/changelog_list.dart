import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/utils/scroll_utils.dart';
import 'package:pubdates/common/utils/typedefs.dart';
import 'package:pubdates/common/utils/url_utils.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/features/changelog/bloc/changelog_bloc.dart';
import 'package:pubdates/features/changelog/bloc/changelog_state.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/widgets/changelog_loading_progress.dart';
import 'package:pubdates/features/changelog/widgets/changelog_summary.dart';
import 'package:pubdates/features/project/models/package.dart';

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
      context.showErrorSnackBar(context.tr.errorUrlNotOpened(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ChangeLogBloc, ChangeLogState>(
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
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ChangeLogLoadingProgress(),
        ),
      ],
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
    final scrollController = context.read<ScrollManager<Package>>().controller;

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: AppInsets.md),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final item = logs[index];

        return AutoScrollTag(
          key: ValueKey(index),
          index: index,
          controller: scrollController,
          child: ChangeLogSummary(
            changeLog: item,
            onLinkPressed: onLinkPressed,
            onOpenPressed: onLinkPressed == null
                ? null
                : () => onLinkPressed!(item.package.changeLogUrl.toString()),
          ),
        );
      },
    );
  }
}
