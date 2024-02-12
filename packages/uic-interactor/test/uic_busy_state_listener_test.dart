import 'package:test/test.dart';
import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/uic_interactor.dart';

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
    late BusyStateConsumingListener listener;

    setUp(() {
      listener = BusyStateConsumingListener();
    });

    tearDown(() async {
      await listener.release();
    });

    group('run interactor with single listen modifier', () {
      test('should succeed by emitting [true, false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(listener.stream, emitsInOrder([true, false]));
        await interactor(nothing).listenOnBusyState(listener).get();
      });

      test('should fail by emitting [true, false]', () async {
        const interactor = ThrowInteractor();

        expectLater(listener.stream, emitsInOrder([true, false]));
        final future = interactor(nothing).listenOnBusyState(listener).get();

        expect(future, throwsA(isException));
      });
    });

    group('run interactor with multiple listen modifiers', () {
      test('should succeed by emitting [3x true, 3x false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(
          listener.stream,
          emitsInOrder([true, true, true, false, false, false]),
        );

        await interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();
      });

      test('should fail by emitting [3x true, 3x false]', () async {
        const interactor = ThrowInteractor();

        expectLater(
          listener.stream,
          emitsInOrder(
            [true, true, true, false, false, false],
          ),
        );

        final future = interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();

        expect(future, throwsA(isException));
      });
    });
  });

  group('run with buffering listener', () {
    late BusyStateBufferingListener listener;

    setUp(() {
      listener = BusyStateBufferingListener();
    });

    tearDown(() async {
      await listener.release();
    });

    group('run interactor with single listen modifier', () {
      test('should succeed by emitting [true, false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(listener.stream, emitsInOrder([true, false]));
        await interactor(nothing).listenOnBusyState(listener).get();
      });

      test('should fail by emitting [true, false]', () async {
        const interactor = ThrowInteractor();

        expectLater(listener.stream, emitsInOrder([true, false]));
        final future = interactor(nothing).listenOnBusyState(listener).get();
        expect(future, throwsA(isException));
      });
    });

    group('run interactor with multiple listen modifiers', () {
      test('should succeed by emitting [5x true, 1x false]', () async {
        const interactor = NoThrowInteractor();

        expectLater(
          listener.stream,
          emitsInOrder([true, true, true, true, true, false]),
        );

        await interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();
      });

      test('should fail by emitting [5x true, 1x false]', () async {
        const interactor = ThrowInteractor();

        expectLater(
          listener.stream,
          emitsInOrder([true, true, true, true, true, false]),
        );

        final future = interactor(nothing)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .listenOnBusyState(listener)
            .get();

        expect(future, throwsA(isException));
      });
    });
  });
}
