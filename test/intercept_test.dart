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
        () =>
            sut.intercept((e) => interceptedException = e).getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(interceptedException, isA<FormatException>());
    });

    test('should call multiple interceptions', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .intercept((e) => callCount++)
            .intercept((e) => callCount++)
            .intercept((e) => callCount++)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(callCount, equals(3));
    });

    test('should not catch same exception twice', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .intercept((e) => callCount++, handled: true)
            .intercept((e) => callCount++)
            .getOrThrow('input'),
        throwsA(
          isA<HandledException<Exception>>().having(
            (exception) => exception.exception,
            'exception',
            isA<FormatException>(),
          ),
        ),
      );

      expect(callCount, equals(1));
    });

    test('should not catch same exception after second interception', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .intercept((e) => callCount++, handled: false)
            .intercept((e) => callCount++, handled: true)
            .intercept((e) => callCount++)
            .getOrThrow('input'),
        throwsA(
          isA<HandledException<Exception>>().having(
            (exception) => exception.exception,
            'exception',
            isA<FormatException>(),
          ),
        ),
      );

      expect(callCount, equals(2));
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
            .typedIntercept<FormatException>((e) => called = true)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isTrue);
    });

    test('should not intercept exception due to type missmatch', () async {
      var called = false;

      await expectLater(
        () => sut
            .typedIntercept<TimeoutException>((e) => called = true)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isFalse);
    });

    test(
      'should call multiple interceptions',
      () async {
        var callCount = 0;

        await expectLater(
          () => sut
              .typedIntercept<FormatException>((e) => callCount++)
              .typedIntercept<TimeoutException>((e) => callCount++)
              .intercept((e) => callCount++)
              .getOrThrow('input'),
          throwsA(isA<FormatException>()),
        );

        expect(callCount, equals(2));
      },
    );

    test('should not catch same exception twice', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .typedIntercept<FormatException>(
              (e) => callCount++,
              handled: true,
            )
            .typedIntercept<FormatException>((e) => callCount++)
            .getOrThrow('input'),
        throwsA(isA<HandledException<FormatException>>()),
      );

      expect(callCount, equals(1));
    });

    test('should not catch same exception after second interception', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .typedIntercept<FormatException>(
              (e) => callCount++,
              handled: false,
            )
            .typedIntercept<FormatException>(
              (e) => callCount++,
              handled: true,
            )
            .typedIntercept<FormatException>((e) => callCount++)
            .getOrThrow('input'),
        throwsA(isA<HandledException<FormatException>>()),
      );

      expect(callCount, equals(2));
    });
  });

  group('checkedIntercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should intercept exception', () async {
      var called = false;

      await expectLater(
        () => sut
            .checkedIntercept((e) => called = true, (_) => true)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isTrue);
    });

    test('should not intercept exception due to unsatisfied predicate',
        () async {
      var called = false;

      await expectLater(
        () => sut
            .checkedIntercept((e) => called = true, (_) => false)
            .getOrThrow('input'),
        throwsA(isA<FormatException>()),
      );

      expect(called, isFalse);
    });

    test('should not catch same exception twice', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .checkedIntercept(
              (e) => callCount++,
              (_) => true,
              handled: true,
            )
            .checkedIntercept(
              (e) => callCount++,
              (_) => true,
            )
            .getOrThrow('input'),
        throwsA(isA<HandledException<Exception>>()),
      );

      expect(callCount, equals(1));
    });

    test('should not catch same exception after second interception', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .checkedIntercept(
              (e) => callCount++,
              (_) => true,
              handled: false,
            )
            .checkedIntercept(
              (e) => callCount++,
              (_) => true,
              handled: true,
            )
            .checkedIntercept(
              (e) => callCount++,
              (_) => true,
            )
            .getOrThrow('input'),
        throwsA(isA<Exception>()),
      );

      expect(callCount, equals(2));
    });
  });
}
