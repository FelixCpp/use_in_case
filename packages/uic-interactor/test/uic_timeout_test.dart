import 'dart:async';

import 'package:test/test.dart';
import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/uic_interactor.dart';

class _DelayedReturnInteractor extends ResultInteractor<int> {
  const _DelayedReturnInteractor();

  @override
  Future<int> execute(Nothing input) {
    return Future.delayed(const Duration(milliseconds: 50), () => 30);
  }
}

void main() {
  group('run interactor with single timeout modifier', () {
    late _DelayedReturnInteractor interactor;

    setUp(() {
      interactor = _DelayedReturnInteractor();
    });

    test('should succeed with value 30', () async {
      final result = await interactor(nothing)
          .timeout(const Duration(milliseconds: 75))
          .get();

      expect(result, equals(30));
    });

    test('should fail with timeout exception', () {
      const Duration duration = Duration(milliseconds: 25);
      const String message = '25ms';

      final result =
          interactor(nothing).timeout(duration, message: message).get();

      expect(
        result,
        throwsA(
          isA<TimeoutException>()
              .having(
                (exception) => exception.duration,
                'duration',
                equals(duration),
              )
              .having(
                (exception) => exception.message,
                'message',
                equals(message),
              ),
        ),
      );
    });
  });

  group('run interactor with multiple timeout modifiers', () {
    late _DelayedReturnInteractor interactor;

    setUp(() {
      interactor = _DelayedReturnInteractor();
    });

    test('should succeed with value 30', () async {
      final result = interactor(nothing)
          .timeout(const Duration(milliseconds: 250))
          .timeout(const Duration(milliseconds: 100), message: '100ms')
          .get();

      expect(result, completion(equals(30)));
    });

    test('should fail with timeout exception', () {
      final result = interactor(nothing)
          .timeout(const Duration(milliseconds: 150), message: '150ms')
          .timeout(const Duration(milliseconds: 10), message: '10ms')
          .get();

      expect(
        result,
        throwsA(
          isA<TimeoutException>()
              .having(
                (exception) => exception.message,
                'message',
                equals('10ms'),
              )
              .having(
                (exception) => exception.duration,
                'duration',
                const Duration(milliseconds: 10),
              ),
        ),
      );
    });
  });
}
