import 'dart:math' as math show pi;

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_completion_details.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/profiler_invocation_modifier.dart';

class ReturnPiAfterDelayInteractor
    implements ParameterizedResultInteractor<Duration, double> {
  const ReturnPiAfterDelayInteractor();

  @override
  Future<double> execute(Duration delay) {
    return Future.delayed(delay, () => math.pi);
  }
}

Future<void> main() async {
  const logger = TestLogger();
  const heavyMath = ReturnPiAfterDelayInteractor();

  final result = await heavyMath(Duration(milliseconds: 750))
      .timeout(Duration(milliseconds: 100))
      .profiler(logger)
      .getOrNull();

  print("Result: $result");

  ///
  /// ~ Program Output ~
  /// ReturnPiAfterDelayInteractor started
  /// ReturnPiAfterDelayInteractor failed after 0:00:00.103255 due to TimeoutException after 0:00:00.100000
  /// Result: null
  ///
}

class TestLogger implements InvocationProfilerLogger {
  const TestLogger();

  @override
  void onInvocationStart(InvocationDetails details) {
    print('${details.jobName} started');
  }

  @override
  void onInvocationFailure(
    InvocationDetails details,
    InvocationFailureDetails invocation,
  ) {
    print(
      '${details.jobName} failed after ${invocation.elapsedTime} due to ${invocation.exception}',
    );
  }

  @override
  void onInvocationSuccess<T>(
    InvocationDetails details,
    InvocationSuccessDetails<T> invocation,
  ) {
    print(
      '${details.jobName} succeeded after ${invocation.elapsedTime} with value "${invocation.output}"',
    );
  }
}
