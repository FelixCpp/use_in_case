import 'dart:async';

import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('intercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should intercept exception', () async {
      Exception? interceptedException;

      await expectLater(
        () => sut
            .intercept((e) async => interceptedException = e)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(interceptedException, isA<FormatException>());
    });
  });

  group('typedIntercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should intercept exception', () async {
      var called = false;

      await expectLater(
        () => sut
            .typedIntercept<FormatException>((e) async => called = true)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isTrue);
    });

    test('should not intercept exception due to type missmatch', () async {
      var called = false;

      await expectLater(
        () => sut
            .typedIntercept<TimeoutException>((e) async => called = true)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isFalse);
    });
  });
}
