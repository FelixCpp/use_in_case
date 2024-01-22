import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_execution_listener/uic_interactor_execution_listener.dart';

class ReturnInputAfterDelayInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  const ReturnInputAfterDelayInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 81);
  }
}

void main() {
  group('run interactor with single publishTo modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    tearDown(() async {});

    test('should emit true, false in order', () async {
      final listener = InteractorExecutionUnicastListener();
      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });

    test('should emit true, false in order', () async {
      final listener = InteractorExecutionBroadcastListener();
      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });
  });

  group('run interactor with multiple publishTo modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    tearDown(() async {});

    test('should emit true, true, false, false in order', () async {
      final listener = InteractorExecutionUnicastListener();
      expectLater(listener.isLoading, emitsInOrder([true, true, false, false]));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });

    test('should emit true, true, true, false in order', () async {
      final listener = InteractorExecutionBroadcastListener();
      expectLater(listener.isLoading, emitsInOrder([true, true, true, false]));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);

      await listener.release();
    });
  });

  group('run interactor with single publishInto modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test('should add true, false into list', () async {
      final states = List<bool>.empty(growable: true);
      final result = await interactor(Duration(milliseconds: 50))
          .publishInto((isBusy) => states.add(isBusy))
          .getOrElse(fallback: -1);

      expect(result, equals(81));
      expect(states, equals(List.of({true, false})));
    });
  });

  group('run interactor with multiple publishInto modifier', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = ReturnInputAfterDelayInteractor();
    });

    test('should add true, true, true, false into list', () async {
      final states = List<bool>.empty(growable: true);
      final result = await interactor(Duration(milliseconds: 50))
          .publishInto((isBusy) => states.add(isBusy))
          .publishInto((isBusy) => states.add(isBusy))
          .getOrElse(fallback: -1);

      expect(result, equals(81));
      expect(states, equals([true, true, false, false]));
    });
  });
}
