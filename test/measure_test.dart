import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group("measureTime", () {
    test('should measure at least a runtime of 100ms', () async {
      final ParameterizedResultInteractor<Duration, int> sut =
          WaitingInteractor();
      Duration? measuredTime;

      final waitedMillis = await sut.measureTime((elapsed) async {
        measuredTime = elapsed;
      }).getOrThrow(Duration(milliseconds: 100));

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
      expect(waitedMillis, equals(100));
    });

    test(
      "should measure at least a runtime of 100ms even when throwing",
      () async {
        final Interactor sut = ThrowingInteractor();
        Duration? measuredTime;

        final result = sut
            .eventually(() => Future.delayed(Duration(milliseconds: 100)))
            .measureTime((elapsed) => measuredTime = elapsed)
            .getOrThrow(unit);

        await expectLater(result, throwsException);
        expect(measuredTime, isNotNull);
        expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
      },
    );
  });

  group('measureTimeOnSuccess', () {
    test('should measure time', () async {
      ParameterizedResultInteractor<Duration, int> sut = WaitingInteractor();
      Duration? measuredTime;

      final waitedMillis = await sut.measureTimeOnSuccess((elapsed, _) {
        measuredTime = elapsed;
      }).getOrThrow(Duration(milliseconds: 100));

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
      expect(waitedMillis, equals(100));
    });

    test('should not measure time due to exception', () async {
      final Interactor sut = ThrowingInteractor();
      Duration? measuredTime;

      final result = sut
          .measureTimeOnSuccess((elapsed, _) => measuredTime = elapsed)
          .getOrThrow(unit);

      await expectLater(result, throwsException);
      expect(measuredTime, isNull);
    });
  });

  group('measureTimedValue', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should output the duration and result of the interactor', () async {
      final (duration, value) = await sut
          .after((_) => Future.delayed(const Duration(milliseconds: 100)))
          .measureTimedValue()
          .getOrThrow('42');

      expect(duration, greaterThanOrEqualTo(const Duration(milliseconds: 100)));
      expect(value, equals(42));
    });

    test(
      'should output the duration and result of the interactor even when throwing',
      () async {
        final Interactor sut = ThrowingInteractor();

        final result = sut
            .eventually(() => Future.delayed(const Duration(milliseconds: 100)))
            .measureTimedValue()
            .getOrThrow(unit);

        await expectLater(result, throwsException);
      },
    );
  });
}
