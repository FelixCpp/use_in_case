import 'dart:async';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:uic_interactor/uic-interactor.dart';

final class _WaitingInteractor extends PRInteractor<Duration, int> {
  @override
  Future<int> execute(Duration parameter) {
    return Future.delayed(parameter, () => 42);
  }
}

void main() {
  group('single timeout modifier', () {
    late PRInteractor<Duration, int> interactor;

    setUp(() {
      interactor = _WaitingInteractor();
    });

    test('should succeed after 0.25 seconds with an result of 42', () {
      final result = interactor(Duration(milliseconds: 250))
          .timeout(Duration(milliseconds: 500))
          .get();
      expect(result, completion(42));
    });

    test('should fail after 0.25 seconds with a TimeoutException', () {
      const timeoutDuration = Duration(milliseconds: 250);
      const timeoutMessage = 'Timeout Message';

      expect(
        interactor(Duration(milliseconds: 300))
            .timeout(timeoutDuration, timeoutMessage)
            .get(),
        throwsA(
          isA<TimeoutException>()
              .having((exception) => exception.duration, 'duration',
                  equals(timeoutDuration))
              .having((exception) => exception.message, 'message',
                  equals(timeoutMessage)),
        ),
      );
    });

    test('should fail after 0.25 seconds with null', () {
      const timeoutDuration = Duration(milliseconds: 250);
      const timeoutMessage = 'Timeout Message';

      expect(
        interactor(Duration(milliseconds: 300))
            .timeout(timeoutDuration, timeoutMessage)
            .getOrNull(),
        completion(isNull),
      );
    });

    test('should fail after 0.25 seconds with -1', () {
      const timeoutDuration = Duration(milliseconds: 250);
      const timeoutMessage = 'Timeout Message';

      expect(
        interactor(Duration(milliseconds: 300))
            .timeout(timeoutDuration, timeoutMessage)
            .getOrElse(() => -1),
        completion(equals(-1)),
      );
    });
  });

  group('multiple timeout modifier', () {
    late PRInteractor<Duration, int> interactor;

    setUp(() {
      interactor = _WaitingInteractor();
    });

    test('should throw timeout exception with the lowest duration', () {
      expect(
        interactor(Duration(milliseconds: 300))
            .timeout(Duration(milliseconds: 260), 'Timeout Message 1')
            .timeout(Duration(milliseconds: 220), 'Timeout Message 2')
            .timeout(Duration(milliseconds: 240), 'Timeout Message 3')
            .timeout(Duration(milliseconds: 250), 'Timeout Message 4')
            .get(),
        throwsA(
          isA<TimeoutException>()
              .having((exception) => exception.duration, 'duration',
                  equals(Duration(milliseconds: 220)))
              .having((exception) => exception.message, 'message',
                  equals('Timeout Message 2')),
        ),
      );
    });
  });
}
