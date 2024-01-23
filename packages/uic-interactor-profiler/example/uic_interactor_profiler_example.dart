import 'dart:math' as math show pi;

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/profiler_extension.dart';

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

  final result =
      await heavyMath(Duration(milliseconds: 750)).profiler(logger).getOrNull();

  print("Result: $result");

  ///
  /// ~ Program Output ~
  /// ReturnPiAfterDelayInteractor started
  /// ReturnPiAfterDelayInteractor failed after 0:00:00.103255 due to TimeoutException after 0:00:00.100000
  /// Result: null
  ///
}

class TestLogger implements InvocationEventProfiler {
  const TestLogger();

  @override
  void onInvocationStart<T>({
    required InvocationDetails details,
    required T input,
  }) {
    print('${details.jobName} started');
  }

  @override
  void onInvocationSuccess<T>({
    required InvocationDetails details,
    required Duration elapsedTime,
    required T output,
  }) {
    print(
      '${details.jobName} succeeded after $elapsedTime with value "$output"',
    );
  }

  @override
  void onInvocationFailure({
    required InvocationDetails details,
    required Duration elapsedTime,
    required Exception exception,
  }) {
    print(
      '${details.jobName} failed after $elapsedTime due to $exception',
    );
  }
}
