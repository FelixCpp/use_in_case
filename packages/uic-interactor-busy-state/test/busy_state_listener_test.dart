import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state/uic_interactor_busy_state.dart';

class NoThrowInteractor extends Interactor {
  const NoThrowInteractor();

  @override
  Future<void> execute(Nothing _) async {}
}

class ThrowInteractor extends Interactor {
  const ThrowInteractor();

  @override
  Future<void> execute(Nothing _) {
    return Future.error(Exception('Test Exception'));
  }
}

void main() {
  group('run with consuming listener', () {
    late BusyStateListener listener;

    setUp(() {
      listener = BusyStateConsumingListener();
    });

    tearDown(() async {
      await listener.release();
    });

    group('run interactor with single listen modifier', () {
      test('should succeed by emitting [true, false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(listener.isLoading, emitsInOrder([true, false]));
        final _ = await interactor(nothing).listenOnBusyState(listener).get();
      });

      test('should fail by emitting [true, false]', () async {
        const interactor = ThrowInteractor();

        expectLater(listener.isLoading, emitsInOrder([true, false]));
        final result = interactor(nothing).listenOnBusyState(listener).get();
        expect(result, throwsA(isException));
      });
    });

    group('run interactor with multiple listen modifiers', () {
      test('should succeed by emitting [3x true, 3x false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(
          listener.isLoading,
          emitsInOrder([true, true, true, false, false, false]),
        );

        final _ = await interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();
      });

      test('should fail by emitting [3x true, 3x false]', () async {
        const interactor = ThrowInteractor();

        expectLater(
          listener.isLoading,
          emitsInOrder([true, true, true, false, false, false]),
        );

        final result = interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();

        expect(result, throwsA(isException));
      });
    });
  });

  group('run with buffering listener', () {
    late BusyStateListener listener;

    setUp(() {
      listener = BusyStateBufferingListener();
    });

    tearDown(() async {
      await listener.release();
    });

    group('run interactor with single listen modifier', () {
      test('should succeed by emitting [true, false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(listener.isLoading, emitsInOrder([true, false]));
        final _ = await interactor(nothing).listenOnBusyState(listener).get();
      });

      test('should fail by emitting [true, false]', () async {
        const interactor = ThrowInteractor();

        expectLater(listener.isLoading, emitsInOrder([true, false]));
        final result = interactor(nothing).listenOnBusyState(listener).get();
        expect(result, throwsA(isException));
      });
    });

    group('run interactor with multiple listen modifiers', () {
      test('should succeed by emitting [5x true, 1x false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(
          listener.isLoading,
          emitsInOrder([true, true, true, true, true, false]),
        );

        final _ = await interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();
      });

      test('should fail by emitting [5x true, 1x false]', () async {
        const interactor = ThrowInteractor();

        expectLater(
          listener.isLoading,
          emitsInOrder([true, true, true, true, true, false]),
        );

        final result = interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();

        expect(result, throwsA(isException));
      });
    });
  });
}
