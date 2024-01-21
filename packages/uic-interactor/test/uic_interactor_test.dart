import 'dart:async';

import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';

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

class ThrowExceptionInteractor
    implements ParameterizedResultInteractor<int, int> {
  const ThrowExceptionInteractor();

  @override
  Future<int> execute(int input) async {
    throw Exception('Error');
  }
}

void main() {
  group('run interactor via explicit configuration', () {
    test('should return 500 after 100 milliseconds', () {
      final completer = Completer<int>();
      const interactor = ReturnInputAfterDelayInteractor<int>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 100),
          result: 500,
        ),
      ).configure(
        (event) {
          event.whenOrNull(
            onSuccess: (data) => completer.complete(data),
          );
        },
      ).run();

      expect(completer.future, completion(equals(500)));
    });

    test('should return "Hello" immediately', () {
      final completer = Completer<String>();
      const interactor = ReturnInputAfterDelayInteractor<String>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration.zero,
          result: 'Hello',
        ),
      ).configure(
        (event) {
          event.whenOrNull(
            onSuccess: (data) => completer.complete(data),
          );
        },
      ).run();

      expect(completer.future, completion(equals('Hello')));
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

  group('run interactor via get[Or[Null|Else]] method', () {
    test('should return 600', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();

      final result = await interactor(
        ReturnInputAfterDelayParams(delay: Duration.zero, result: 600),
      ).get();

      expect(result, equals(600));
    });

    test('should return null', () async {
      const interactor = ThrowExceptionInteractor();
      final result = await interactor(0).getOrNull();
      expect(result, isNull);
    });

    test('should return -1', () async {
      const interactor = ThrowExceptionInteractor();
      final result = await interactor(0).getOrElse(fallback: -1);
      expect(result, equals(-1));
    });
  });
}
