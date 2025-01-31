import 'dart:async';

import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('busyState', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should invoke callback in correct order', () async {
      final order = <bool>[];

      await sut.busyStateChange((isBusy) => order.add(isBusy)).getOrThrow('42');

      expect(order, orderedEquals([true, false]));
    });

    test('should invoke callback in correct order with exception', () async {
      final order = <bool>[];

      await expectLater(
        () => sut
            .busyStateChange((isBusy) => order.add(isBusy))
            .getOrThrow('NaN'),
        throwsA(isA<FormatException>()),
      );

      expect(order, orderedEquals([true, false]));
    });
  });

  group('emitBusyStateChange', () {
    late StreamController<IsBusy> controller;
    late StreamSubscription<IsBusy> subscription;
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      controller = StreamController();
      sut = TestInteractor();
    });

    tearDown(() {
      subscription.cancel();
      return controller.close();
    });

    test('should emit busy states into controller', () async {
      final states = <IsBusy>[];

      subscription = controller.stream.listen((isBusy) {
        states.add(isBusy);
      });

      final result = await sut.emitBusyStateChange(controller).getOrThrow('42');

      expect(states, orderedEquals([true, false]));
      expect(result, 42);
    });

    test('should emit busy states into controller with exception', () async {
      final states = <IsBusy>[];

      subscription = controller.stream.listen((isBusy) {
        states.add(isBusy);
      });

      await expectLater(
        () => sut.emitBusyStateChange(controller).getOrThrow('NaN'),
        throwsA(isA<FormatException>()),
      );

      expect(states, orderedEquals([true, false]));
    });
  });
}
