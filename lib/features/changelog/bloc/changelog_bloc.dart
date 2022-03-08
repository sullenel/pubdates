import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:pubdates/features/changelog/bloc/changelog_event.dart';
import 'package:pubdates/features/changelog/bloc/changelog_state.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/repositories/changelog_repository.dart';
import 'package:pubdates/features/project/models/package.dart';

class ChangeLogBloc extends Bloc<ChangeLogEvent, ChangeLogState> {
  ChangeLogBloc({
    required ChangeLogRepository changeLogRepository,
  })  : _changeLogRepository = changeLogRepository,
        super(const ChangeLogState.waitingForPackages()) {
    on<ChangeLogEvent>(
      (event, emit) => event.map(
        load: (event) => _handleLoadLogs([event.package], emit),
        loadAll: (event) => _handleLoadLogs(event.packages, emit),
      ),
      transformer: transformers.sequential(),
    );
  }

  final ChangeLogRepository _changeLogRepository;

  Future<void> _handleLoadLogs(
    Iterable<Package> packages,
    Emitter<ChangeLogState> emit,
  ) async {
    return state.mapOrNull<Future<void>>(
      waitingForPackages: (_) async {
        final pending = DoubleLinkedQueue<Package>.of(packages);
        var loaded = <PackageChangeLog>[];

        emit(ChangeLogState.loading(pending: pending, loaded: loaded));

        while (pending.isNotEmpty) {
          final package = pending.removeFirst();

          try {
            final changeLog =
                await _changeLogRepository.changeLogForPackage(package);

            loaded = [...loaded, changeLog];
            emit(ChangeLogState.loading(pending: pending, loaded: loaded));
          } on Exception catch (error, stackTrace) {
            // TODO: handle errors
            pending.addLast(package);
          }
        }

        emit(ChangeLogState.loaded(loaded: loaded));
      },
    );
  }
}
