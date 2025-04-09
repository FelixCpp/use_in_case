import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('checkedIntercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test(
      'should catch handled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .checkedIntercept(
                (exception) => caught = true,
                (exception) => exception is FormatException,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<Exception>>()),
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch unhandled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .checkedIntercept(
                (exception) => caught = true,
                (exception) => exception is FormatException,
                consume: false,
              )
              .getOrThrow('invalid'),
          throwsException,
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch only all exception down to first consumer',
      () async {
        var firstCaught = false;
        var secondCaught = false;
        var thirdCaught = false;

        await expectLater(
          () => sut
              .checkedIntercept(
                (exception) => firstCaught = true,
                (exception) => true,
                consume: false,
              )
              .checkedIntercept(
                (exception) => secondCaught = true,
                (exception) => true,
              )
              .checkedIntercept(
                (exception) => thirdCaught = true,
                (exception) => true,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<Exception>>()),
        );

        expect(firstCaught, isTrue);
        expect(secondCaught, isTrue);
        expect(thirdCaught, isFalse);
      },
    );

    test('should not catch exception due to valid input', () async {
      var caught = false;

      await expectLater(
        sut
            .checkedIntercept(
              (exception) => caught = true,
              (exception) => exception is FormatException,
            )
            .getOrThrow('42'),
        completion(equals(42)),
      );

      expect(caught, isFalse);
    });
  });

  group('typedIntercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test(
      'should catch handled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .typedIntercept<FormatException>(
                (exception) => caught = true,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<FormatException>>()),
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch unhandled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .typedIntercept<FormatException>(
                (exception) => caught = true,
                consume: false,
              )
              .getOrThrow('invalid'),
          throwsException,
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch only all exception down to first consumer',
      () async {
        var firstCaught = false;
        var secondCaught = false;
        var thirdCaught = false;

        await expectLater(
          () => sut
              .typedIntercept<FormatException>(
                (exception) => firstCaught = true,
                consume: false,
              )
              .typedIntercept<FormatException>(
                (exception) => secondCaught = true,
              )
              .typedIntercept<FormatException>(
                (exception) => thirdCaught = true,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<FormatException>>()),
        );

        expect(firstCaught, isTrue);
        expect(secondCaught, isTrue);
        expect(thirdCaught, isFalse);
      },
    );
  });

  group('intercept', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test(
      'should catch handled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .intercept(
                (exception) => caught = true,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<Exception>>()),
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch unhandled exception due to invalid conversion parameter',
      () async {
        var caught = false;

        await expectLater(
          () => sut
              .intercept(
                (exception) => caught = true,
                consume: false,
              )
              .getOrThrow('invalid'),
          throwsException,
        );

        expect(caught, isTrue);
      },
    );

    test(
      'should catch only all exception down to first consumer',
      () async {
        var firstCaught = false;
        var secondCaught = false;
        var thirdCaught = false;

        await expectLater(
          () => sut
              .intercept(
                (exception) => firstCaught = true,
                consume: false,
              )
              .intercept(
                (exception) => secondCaught = true,
              )
              .intercept(
                (exception) => thirdCaught = true,
              )
              .getOrThrow('invalid'),
          throwsA(isA<HandledException<Exception>>()),
        );

        expect(firstCaught, isTrue);
        expect(secondCaught, isTrue);
        expect(thirdCaught, isFalse);
      },
    );
  });
}
