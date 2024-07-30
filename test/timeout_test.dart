import 'dart:async';

import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('timeout', () {
    late ParameterizedResultInteractor<Duration, int> sut;

    setUp(() {
      sut = WaitingInteractor();
    });

    test('should timeout after 200ms', () async {
      await expectLater(
        () => sut
            .timeout(const Duration(milliseconds: 200))
            .getOrThrow(Duration(milliseconds: 300)),
        throwsA(
          isA<TimeoutException>().having(
            (exception) => exception.duration,
            'duration',
            equals(const Duration(milliseconds: 200)),
          ),
        ),
      );
    });

    test('should throw with correct error message', () async {
      await expectLater(
        () => sut
            .timeout(
              const Duration(milliseconds: 200),
              errorMessage: 'bruh',
            )
            .getOrThrow(Duration(milliseconds: 1000)),
        throwsA(
          isA<TimeoutException>()
              .having(
                (exception) => exception.duration,
                'duration',
                equals(const Duration(milliseconds: 200)),
              )
              .having(
                (exception) => exception.message,
                'message',
                equals('bruh'),
              ),
        ),
      );
    });

    test('should timeout after shortest duration', () async {
      await expectLater(
        () => sut
            .timeout(const Duration(milliseconds: 600))
            .timeout(const Duration(milliseconds: 200))
            .timeout(const Duration(milliseconds: 70000))
            .getOrThrow(Duration(milliseconds: 1000)),
        throwsA(
          isA<TimeoutException>().having(
            (exception) => exception.duration,
            'duration',
            equals(const Duration(milliseconds: 200)),
          ),
        ),
      );
    });

    test('should not timeout', () async {
      final result = await sut
          .timeout(const Duration(milliseconds: 200))
          .getOrThrow(Duration(milliseconds: 10));
      expect(result, 10);
    });
  });
}
