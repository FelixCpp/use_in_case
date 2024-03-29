import 'package:uic_interactor/src/modifiers/busy_state/busy_state_modifier_builder.dart';
import 'package:uic_interactor/src/modifiers/busy_state/listener/busy_state_buffering_listener.dart';
import 'package:uic_interactor/src/modifiers/busy_state/listener/busy_state_consuming_listener.dart';
import 'package:uic_interactor/uic_interactor.dart';

class WaitingInteractor extends ParameterizedResultInteractor<Duration, int> {
  const WaitingInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 99);
  }
}

Future<void> exampleWithReceiver() async {
  const interactor = WaitingInteractor();
  final stopwatch = Stopwatch();

  final result = await interactor(
    const Duration(milliseconds: 50),
  ).receiveBusyStateChange((isBusy) {
    if (isBusy) {
      stopwatch.start();
    } else {
      stopwatch.stop();
    }
  }).get();

  final elapsedTime = stopwatch.elapsed;
  print('Task took $elapsedTime and returned $result');
}

Future<void> exampleWithConsumingListener() async {
  const interactor = WaitingInteractor();
  final listener = BusyStateConsumingListener();
  final stopwatch = Stopwatch();

  listener.listen((isBusy) {
    if (isBusy) {
      stopwatch.start();
    } else {
      stopwatch.stop();
    }
  });

  final result = await interactor(
    const Duration(milliseconds: 50),
  ).listenOnBusyState(listener).get();

  final elapsedTime = stopwatch.elapsed;
  print('Task took $elapsedTime and returned $result');

  await listener.release();
}

Future<void> exampleWithBufferingListener() async {
  const interactor = WaitingInteractor();
  final listener = BusyStateBufferingListener();
  final stopwatch = Stopwatch();

  listener.listen((isBusy) {
    if (isBusy) {
      stopwatch.start();
    } else {
      stopwatch.stop();
    }
  });

  final results = await Future.wait({
    interactor(const Duration(milliseconds: 50))
        .listenOnBusyState(listener)
        .get(),
    interactor(const Duration(milliseconds: 100))
        .listenOnBusyState(listener)
        .get()
  });

  final elapsedTime = stopwatch.elapsed;
  print('Task took $elapsedTime and returned $results');

  await listener.release();
}

Future<void> main() async {
  await exampleWithReceiver();
  await exampleWithConsumingListener();
  await exampleWithBufferingListener();
}
