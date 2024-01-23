import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state_listener/uic_interactor_busy_state_listener.dart';

class Return500AfterDelayInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  const Return500AfterDelayInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 500);
  }
}

Future<void> exampleWithListenerInstance() async {
  final listener = BusyStateConsumingListener();
  const interactor = Return500AfterDelayInteractor();

  final subscription = listener.isLoading.listen((isLoading) {
    print('Interactor is working: $isLoading');
  });

  final result = await interactor(Duration(milliseconds: 750))
      .listenOnBusyState(listener)
      .get();

  await subscription.cancel();
  await listener.release();

  print('Computation result: $result');

  ///
  /// ~ Function Output ~
  /// Interactor is working: true
  /// Interactor is working: false
  /// Computation result: 500
  ///
}

Future<void> exampleWithListenerCallback() async {
  const interactor = Return500AfterDelayInteractor();
  final completer = Completer<int>();

  interactor(Duration(milliseconds: 750)).receiveBusyStateChange((isLoading) {
    print('Interactor is working $isLoading');
  }).configure((event) {
    event.whenOrNull(
      onStart: (input) {
        print('Started');
      },
      onSuccess: (data) {
        print('Succeeded');
        completer.complete(data);
      },
      onFailure: (exception) {
        print('Failure');
        completer.completeError(exception);
      },
    );
  }).run();

  await completer.future.then((result) {
    print('Computation result: $result');
  });

  ///
  /// ~ Function Output ~
  /// Interactor is working true
  /// Started
  /// Succeeded
  /// Interactor is working false
  /// Computation result: 500
  ///
}

Future<void> main() async {
  await exampleWithListenerInstance();
  await exampleWithListenerCallback();
}
