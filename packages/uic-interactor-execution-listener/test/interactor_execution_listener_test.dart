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
  group(InteractorExecutionUnicastListener, () {
    test('should notify when interactor is called', () async {
      const interactor = ReturnInputAfterDelayInteractor();
      final listener = InteractorExecutionUnicastListener();

      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);
    });

    test('should notify twice when interactor is called', () async {
      const interactor = ReturnInputAfterDelayInteractor();
      final listener = InteractorExecutionUnicastListener();

      expectLater(listener.isLoading, emitsInOrder([true, true, false, false]));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);
    });
  });

  group(InteractorExecutionBroadcastListener, () {
    test('should notify when interactor is called', () async {
      const interactor = ReturnInputAfterDelayInteractor();
      final listener = InteractorExecutionBroadcastListener();

      expectLater(listener.isLoading, emitsInOrder({true, false}));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);
    });

    test('should notify twice when interactor is called', () async {
      const interactor = ReturnInputAfterDelayInteractor();
      final listener = InteractorExecutionBroadcastListener();

      expectLater(listener.isLoading, emitsInOrder([true, true, true, false]));

      final result = await interactor(Duration(milliseconds: 50))
          .publishTo(listener)
          .publishTo(listener)
          .getOrElse(fallback: -1);

      expect(result, 81);
    });
  });
}
