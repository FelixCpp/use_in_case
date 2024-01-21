import 'dart:async';

import 'package:logger/logger.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_completion_details.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/profiler_invocation_modifier.dart';

class MyInteractor implements ParameterizedResultInteractor<int, int> {
  @override
  Future<int> execute(int input) {
    return Future.delayed(Duration(milliseconds: 250), () => input);
  }
}

class DefaultLogger implements InvocationProfilerLogger {
  final logger = Logger();
  int startCount = 0;
  int successCount = 0;
  int failureCount = 0;

  @override
  void onInvocationStart(InvocationDetails details) {
    logger.i('${details.jobName} started');
    ++startCount;
  }

  @override
  void onInvocationSuccess<T>(
    InvocationDetails details,
    InvocationSuccessDetails<T> invocation,
  ) {
    logger.i('${details.jobName} succeeded with ${invocation.output}');
    ++successCount;
  }

  @override
  void onInvocationFailure(
    InvocationDetails details,
    InvocationFailureDetails invocation,
  ) {
    logger.e(
      '${details.jobName} failed after ${invocation.elapsedTime} with ${invocation.exception}',
    );
    ++failureCount;
  }
}

void main() {
  test('Should succeed with result and method counts', () async {
    final logger = DefaultLogger();
    final interactor = MyInteractor();
    final result = await interactor(120).profiler(logger).get();

    expect(result, equals(120));
    expect(logger.startCount, equals(1));
    expect(logger.successCount, equals(1));
    expect(logger.failureCount, equals(0));
  });

  test('Should fail with result and method counts', () async {
    final logger = DefaultLogger();
    final interactor = MyInteractor();
    final result =
        await interactor(120).profiler(logger).profiler(logger).get();

    expect(result, equals(120));
    expect(logger.startCount, equals(2));
    expect(logger.successCount, equals(2));
    expect(logger.failureCount, equals(0));
  });

  test('Should fail with timeout', () async {
    final logger = DefaultLogger();
    final interactor = MyInteractor();

    try {
      await interactor(120)
          .profiler(logger)
          .timeout(Duration(milliseconds: 100))
          .get();

      fail('No exception has been thrown');
    } on TimeoutException catch (_) {
      expect(logger.startCount, equals(1));
      expect(logger.successCount, equals(0));
      expect(logger.failureCount, equals(1));
    } catch (exception) {
      fail('Unexpected exception type has been thrown');
    }
  });
}
