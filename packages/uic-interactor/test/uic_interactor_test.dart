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
    extends ParameterizedResultInteractor<ReturnInputAfterDelayParams<T>, T> {
  const ReturnInputAfterDelayInteractor();

  @override
  Future<T> execute(ReturnInputAfterDelayParams args) {
    return Future.delayed(args.delay, () => args.result);
  }
}

class ThrowExceptionInteractor extends ParameterizedResultInteractor<int, int> {
  const ThrowExceptionInteractor();

  @override
  Future<int> execute(int input) async {
    throw Exception('Error');
  }
}

void main() {
  group('run interactor via configuration', () {
    test('should receive result', () {
      final completer = Completer<int>();
      const interactor = ReturnInputAfterDelayInteractor<int>();

      interactor(
        const ReturnInputAfterDelayParams(
          delay: Duration(milliseconds: 50),
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

    test('should catch exception', () {
      final completer = Completer();
      const interactor = ThrowExceptionInteractor();

      interactor(111).configure(
        (event) {
          event.whenOrNull(
            onFailure: (exception) => completer.completeError(exception),
          );
        },
      ).run();

      expect(completer.future, throwsA(isException));
    });

    test('should notify start', () {
      final completer = Completer<int>();
      const interactor = ThrowExceptionInteractor();

      interactor(111).configure(
        (event) {
          event.whenOrNull(onStart: (input) => completer.complete(input));
        },
      ).run();

      expect(completer.future, completion(equals(111)));
    });
  });

  group('run interactor via get', () {
    test('should return 600', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration.zero,
          result: 600,
        ),
      ).get();

      expect(result, equals(600));
    });

    test('should throw on invocation', () async {
      const interactor = ThrowExceptionInteractor();
      final result = interactor(192).get();
      expect(result, throwsA(isException));
    });
  });

  group('run interactor via getOrNull', () {
    test('should return 300', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration.zero,
          result: 300,
        ),
      ).getOrNull();

      expect(result, equals(300));
    });

    test('should return null', () async {
      const interactor = ThrowExceptionInteractor();
      final result = await interactor(192).getOrNull();
      expect(result, isNull);
    });
  });

  group('run interactor via getOrElse', () {
    test('should return 192', () async {
      const interactor = ReturnInputAfterDelayInteractor<int>();
      final result = await interactor(
        ReturnInputAfterDelayParams(
          delay: Duration.zero,
          result: 192,
        ),
      ).getOrNull();

      expect(result, equals(192));
    });

    test('should return -1 (fallback)', () async {
      const interactor = ThrowExceptionInteractor();
      final result = await interactor(192).getOrElse(fallback: -1);
      expect(result, equals(-1));
    });
  });
}
