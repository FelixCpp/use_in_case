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
          .runAtLeast(Duration(milliseconds: 100))
          .measure((elapsed) => measuredTime = elapsed)
          .run(Duration(milliseconds: 20));

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
    });

    test('should run at least 100ms even when throwing', () async {
      final sut = ThrowingInteractor();
      Duration? measuredTime;

      await sut
          .runAtLeast(Duration(milliseconds: 100))
          .eventually(() => Future.delayed(Duration(milliseconds: 20)))
          .measure((elapsed) => measuredTime = elapsed)
          .run(unit);

      expect(measuredTime, isNotNull);
      expect(measuredTime, greaterThanOrEqualTo(Duration(milliseconds: 100)));
    });
  });
}
