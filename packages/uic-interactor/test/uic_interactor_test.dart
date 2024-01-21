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

void main() {
  group('run interactor via explicit configuration', () {
    test('should return 500 after 1 second', () {
      final completer = Completer<int>();
      const interactor = ReturnInputAfterDelayInteractor<int>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration(seconds: 1),
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

    test('shoud throw timeout exception', () {
      final completer = Completer<double>();
      const interactor = ReturnInputAfterDelayInteractor<double>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 500),
          result: 3.14159,
        ),
      ).timeout(Duration(milliseconds: 250)).configure(
        (event) {
          event.whenOrNull(
            onFailure: (exception) => completer.completeError(exception),
          );
        },
      ).run();

      expect(completer.future, throwsA(isA<TimeoutException>()));
    });
  });
}
