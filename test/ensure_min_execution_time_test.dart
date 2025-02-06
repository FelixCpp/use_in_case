import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('runAtLeast', () {
    test('should run at least 100ms', () async {
      final sut = WaitingInteractor();
      Duration? measuredTime;

      await sut
          .ensureMinExecutionTime(Duration(milliseconds: 100))
          .measureTime((elapsed) => measuredTime = elapsed)
          .run(Duration(milliseconds: 20));

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
    });

    test('should run at least 100ms even when throwing', () async {
      final sut = ThrowingInteractor();
      Duration? measuredTime;

      await sut
          .ensureMinExecutionTime(Duration(milliseconds: 100))
          .eventually(() => Future.delayed(Duration(milliseconds: 20)))
          .measureTime((elapsed) => measuredTime = elapsed)
          .run(unit);

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
    });

    test(
      'should use highest execution time when chaining modifiers',
      () async {
        final sut = WaitingInteractor();
        int callCount = 0;

        await sut
            .ensureMinExecutionTime(
              Duration(milliseconds: 100),
              onDelay: (_) => ++callCount,
            )
            .ensureMinExecutionTime(
              Duration(milliseconds: 50),
              onDelay: (_) => ++callCount,
            )
            .run(Duration(milliseconds: 10));

        expect(callCount, 1);
      },
    );

    test('should not wait if min execution time is below real execution time',
        () async {
      final sut = WaitingInteractor();
      Duration? delayTime;

      await sut
          .ensureMinExecutionTime(
            Duration(milliseconds: 0),
            onDelay: (remainingTime) => delayTime = remainingTime,
          )
          .run(Duration(milliseconds: 100));

      expect(delayTime, isNull);
    });
  });
}
