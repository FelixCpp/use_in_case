import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state_listener/uic_interactor_busy_state_listener.dart';

class ReturnInputAfterDelayInteractor
    extends ParameterizedResultInteractor<Duration, int> {
  const ReturnInputAfterDelayInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 81);
  }
}

void main() {
  group('run interactor with single listener modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test('should emit true, false in order using consuming listener', () async {
      final listener = BusyStateConsumingListener();
      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .listenOnBusyState(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });

    test('should emit true, false in order using buffering listener', () async {
      final listener = BusyStateBufferingListener();
      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .listenOnBusyState(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });
  });

  group('run interactor with multiple listener modifiers', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test(
      'should emit true, true, false, false in order using consuming listener',
      () async {
        final listener = BusyStateConsumingListener();
        expectLater(
            listener.isLoading, emitsInOrder([true, true, false, false]));

        final result = await interactor(Duration(milliseconds: 50))
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .getOrElse(fallback: -1);

        expect(result, 81);

        await listener.release();
      },
    );

    test(
      'should emit true, true, true, false in order using buffering listener',
      () async {
        final listener = BusyStateBufferingListener();
        expectLater(
            listener.isLoading, emitsInOrder([true, true, true, false]));

        final result = await interactor(Duration(milliseconds: 50))
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .getOrElse(fallback: -1);

        expect(result, 81);

        await listener.release();
      },
    );
  });

  group('run interactor with single receiver modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test('should add true, false into list', () async {
      final states = List<bool>.empty(growable: true);
      final result = await interactor(Duration(milliseconds: 50))
          .receiveBusyStateChange((isBusy) => states.add(isBusy))
          .getOrElse(fallback: -1);

      expect(result, equals(81));
      expect(states, equals(List.of({true, false})));
    });
  });

  group('run interactor with multiple receiver modifiers', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test('should add true, true, true, false into list', () async {
      final states = List<bool>.empty(growable: true);
      final result = await interactor(Duration(milliseconds: 50))
          .receiveBusyStateChange((isBusy) => states.add(isBusy))
          .receiveBusyStateChange((isBusy) => states.add(isBusy))
          .getOrElse(fallback: -1);

      expect(result, equals(81));
      expect(states, equals([true, true, false, false]));
    });
  });
}
