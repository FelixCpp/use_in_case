import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_execution_listener/src/interactor_execution_publisher.dart';
import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_unicast_listener.dart';

class Return500AfterDelayInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  const Return500AfterDelayInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 500);
  }
}

Future<void> exampleWithListenerInstance() async {
  final listener = InteractorExecutionUnicastListener();
  const interactor = Return500AfterDelayInteractor();

  final subscription = listener.isLoading.listen((isLoading) {
    print('Interactor is working: $isLoading');
  });

  final result = await interactor(Duration(milliseconds: 750))
      .publishTo(listener)
      .timeout(Duration(milliseconds: 1000))
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

  final result = await interactor(Duration(milliseconds: 750))
      .publishInto((isLoading) => print('Interactor is working $isLoading'))
      .publishInto((isLoading) => print('LOL'))
      .timeout(Duration(milliseconds: 100))
      .get();

  print('Computation result: $result');

  ///
  /// ~ Function Output ~
  /// Interactor is working: true
  /// Interactor is working: false
  /// Computation result: 500
  ///
}

Future<void> main() async {
  //await exampleWithListenerInstance();
  await exampleWithListenerCallback();
}
