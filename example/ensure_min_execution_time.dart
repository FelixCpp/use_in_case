import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class SynchronizeInteractor extends Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    // .. Perform real synchronization here ...
    return Future.delayed(Duration(milliseconds: 100));
  }
}

void main() async {
  final interactor = SynchronizeInteractor();

  await interactor
      .ensureMinExecutionTime(Duration(milliseconds: 1500))
      .measureTime((duration) => print('Synchronization took $duration'))
      .run();
}
