import 'dart:async';
import 'dart:io';

import 'package:use_in_case/use_in_case.dart';

class SynchronizationInteractor extends Interactor {
  @override
  FutureOr<void> getOrThrow() {
    return Future.delayed(Duration(seconds: 5));
  }
}

void main() async {
  final interactor = SynchronizationInteractor();

  await interactor
      .timeout(const Duration(seconds: 3))
      .before((_) => stdout.writeln('Started to synchronize'))
      .after((_) => stdout.writeln('Synchronization succeeded'))
      .typedIntercept<TimeoutException>(
        (exception) => stderr.writeln('TimeoutException received: $exception'),
      )
      .eventually(() => stdout.writeln('Synchronization completed'))
      .run();
}
