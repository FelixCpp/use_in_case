import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('logEvents', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should call logStart and logSuccess', () async {
      String? logStartInput;
      int? logSuccessOutput;

      await sut
          .logEvents(
            logStart: (input) => logStartInput = input,
            logSuccess: (_, output) => logSuccessOutput = output,
            logError: (_, __) => fail("logError has been called."),
          )
          .run('24');

      expect(logStartInput, equals('24'));
      expect(logSuccessOutput, equals(24));
    });

    test('should call logStart and logFailure', () async {
      String? logStartInput;
      Exception? logErrorException;

      await sut
          .logEvents(
            logStart: (input) => logStartInput = input,
            logSuccess: (_, __) => fail("logSuccess has been called."),
            logError: (_, exception) => logErrorException = exception,
          )
          .run('bruh');

      expect(logStartInput, equals('bruh'));
      expect(logErrorException, isA<FormatException>());
    });

    test('should not consume exceptions when logError is executed', () async {
      String? logStartInput;
      Exception? logErrorException;
      Exception? caughtException;

      await sut
          .logEvents(
            logStart: (input) => logStartInput = input,
            logSuccess: (_, __) => fail("logSuccess has been called."),
            logError: (_, exception) {
              logErrorException = exception;
            },
          )
          .intercept((exception) => caughtException = exception)
          .run('bruh');

      expect(logStartInput, equals('bruh'));
      expect(caughtException, isA<FormatException>());
      expect(logErrorException, isA<FormatException>());
      expect(caughtException, equals(logErrorException));
    });

    test('should measure each invocation independently', () async {
      final durations = <Duration>[];
      final interactor = WaitingInteractor().logEvents(
        logStart: (_) {},
        logSuccess: (duration, _) => durations.add(duration),
        logError: (_, __) => fail('logError has been called.'),
      );

      await interactor.getOrThrow(const Duration(milliseconds: 150));
      await interactor.getOrThrow(Duration.zero);

      expect(durations, hasLength(2));
      expect(durations[1], lessThan(const Duration(milliseconds: 100)));
    });
  });
}
