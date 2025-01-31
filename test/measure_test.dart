import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group("measure", () {
    test('should measure at least a runtime of 100ms', () async {
      final ParameterizedResultInteractor<Duration, int> sut =
          WaitingInteractor();
      Duration? measuredTime;

      final waitedMillis = await sut.measure((elapsed) async {
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
            .measure((elapsed) => measuredTime = elapsed)
            .runUnsafe(unit);

        await expectLater(result, throwsException);
        expect(measuredTime, isNotNull);
        expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
      },
    );
  });
}
