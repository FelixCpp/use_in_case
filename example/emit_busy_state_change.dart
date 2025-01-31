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

  final subscription =
      streamController.stream.listen((isBusy) => print('Stream: $isBusy'));

  await interactor.emitBusyStateChange(streamController).eventually(() {
    streamController.close();
    subscription.cancel();
  }).run(unit);

  // Output:
  //  - Stream: true
  //  - Working...
  //  - Stream: false
}
