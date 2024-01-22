import 'dart:async';

import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_timeout/uic_interactor_timeout.dart';

class ReturnInputAfterDelayParams<T> {
  final Duration delay;
  final T result;

  const ReturnInputAfterDelayParams({
    required this.delay,
    required this.result,
  });
}

class ReturnInputAfterDelayInteractor<T>
    implements
        ParameterizedResultInteractor<ReturnInputAfterDelayParams<T>, T> {
  const ReturnInputAfterDelayInteractor();

  @override
  Future<T> execute(ReturnInputAfterDelayParams args) {
    return Future.delayed(args.delay, () => args.result);
  }
}

void main() {
  group('run interactor with single timeout modifier', () {
    test('should return 123', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 50),
          result: 123,
        ),
      ).timeout(Duration(milliseconds: 100)).getOrNull();

      expect(result, equals(123));
    });

    test('should return null', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration(seconds: 50),
          result: 123,
        ),
      ).timeout(Duration(milliseconds: 50)).getOrNull();

      expect(result, isNull);
    });
  });

  group('run interactor with multiple timeout modifiers', () {
    test('should return 321', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 50),
          result: 321,
        ),
      )
          .timeout(Duration(milliseconds: 100))
          .timeout(Duration(milliseconds: 75))
          .timeout(Duration(milliseconds: 150))
          .getOrNull();

      expect(result, equals(321));
    });

    test('should throw timeout exception with message "100ms"', () async {
      final completer = Completer<int>();
      const interactor = ReturnInputAfterDelayInteractor<int>();

      interactor(
        ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 150),
          result: 321,
        ),
      )
          .timeout(Duration(milliseconds: 275), message: '275ms')
          .timeout(Duration(milliseconds: 100), message: '100ms')
          .timeout(Duration(milliseconds: 150), message: '150ms')
          .configure((event) {
        event.whenOrNull(onFailure: (ex) => completer.completeError(ex));
      }).run();

      expect(
        completer.future,
        throwsA(
          isA<TimeoutException>().having(
            (error) => error.message,
            'message',
            equals('100ms'),
          ),
        ),
      );
    });
  });
}
