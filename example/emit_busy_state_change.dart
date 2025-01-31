import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class HeavyComputation implements Interactor {
  @override
  FutureOr<void> runUnsafe(Unit input) {
    print('Working...');
  }
}

void main() async {
  final interactor = HeavyComputation();
  final streamController = StreamController<IsBusy>();

  streamController.stream.listen((isBusy) => print('Stream: $isBusy'));

  await interactor
      .busyStateChange((isBusy) => print('Busy: $isBusy'))
      .eventually(() => streamController.close())
      .run(unit);

  // Output:
  //  - Busy: true
  //  - Working...
  //  - Busy: false
}
