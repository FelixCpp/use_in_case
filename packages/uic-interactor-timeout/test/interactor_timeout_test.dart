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
  group('Interactor Timeout Test', () {
    test('should throw due to timeout exception and return null', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration(seconds: 50),
          result: 123,
        ),
      ).timeout(Duration(milliseconds: 50)).getOrNull();

      expect(result, isNull);
    });

    test('shoud throw timeout exception with message', () {
      final completer = Completer<double>();
      const timeoutDuration = Duration(milliseconds: 50);
      const timeoutMessage = 'Some Timeout';
      const interactor = ReturnInputAfterDelayInteractor<double>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 100),
          result: 3.14159,
        ),
      ).timeout(timeoutDuration, message: timeoutMessage).configure(
        (event) {
          event.whenOrNull(
            onFailure: (exception) => completer.completeError(exception),
          );
        },
      ).run();

      expect(
        completer.future,
        throwsA(
          isA<TimeoutException>().having(
            (error) => error.message,
            'message',
            equals(timeoutMessage),
          ),
        ),
      );
    });
  });
}
