import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/widgets/loading_indicator.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/changelog/bloc/changelog_bloc.dart';
import 'package:pubdates/features/changelog/bloc/changelog_state.dart';

extension on ChangeLogState {
  double? get progress => mapOrNull(
        loading: (state) {
          final loadedCount = state.loaded.length;
          final totalCount = loadedCount + state.pending.length;
          return loadedCount / totalCount;
        },
      );
}

extension on BuildContext {
  double? get changeLogLoadingProgress =>
      select<ChangeLogBloc, double?>((bloc) => bloc.state.progress);
}

class ChangeLogLoadingProgress extends StatelessWidget {
  const ChangeLogLoadingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = context.changeLogLoadingProgress;
    return progress == null ? Nothing : LinearLoadingIndicator(value: progress);
  }
}
