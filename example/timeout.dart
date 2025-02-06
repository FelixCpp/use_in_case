import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

class SynchronizationInteractor implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    return Future.delayed(Duration(seconds: 5));
  }
}

void main() async {
  final interactor = SynchronizationInteractor();

  await interactor
      .timeout(const Duration(seconds: 3))
      .before((input) => stdout.writeln('Started to synchronize'))
      .after((_) => stdout.writeln('Synchronization succeeded'))
      .typedIntercept<TimeoutException>(
        (exception) => stderr.writeln('TimeoutException received: $exception'),
      )
      .eventually(() => stdout.writeln('Synchronization completed'))
      .run(unit);
}
