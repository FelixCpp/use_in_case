import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class HeavyComputation extends Interactor {
  @override
  FutureOr<void> getOrThrow() {
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
  }).run();

  // Output:
  //  - Stream: true
  //  - Working...
  //  - Stream: false
}
