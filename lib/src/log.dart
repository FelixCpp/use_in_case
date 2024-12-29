import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension Log<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> logEvents({
    required FutureOr<void> Function(Input) logStart,
    required FutureOr<void> Function(Duration, Output) logSuccess,
    required FutureOr<void> Function(Duration, Exception) logError,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch();
      try {
        await logStart(input);

        stopwatch.start();
        final output = await execute(input);
        stopwatch.stop();

        await logSuccess(stopwatch.elapsed, output);

        return output;
      } on Exception catch (exception) {
        await logError(stopwatch.elapsed, exception);
        rethrow;
      }
    });
  }

  ParameterizedResultInteractor<Input, Output> log({
    required String tag,
    required FutureOr<void> Function(String) logStart,
    required FutureOr<void> Function(String) logSuccess,
    required FutureOr<void> Function(String) logError,
  }) {
    return logEvents(
      logStart: (input) => logStart('$tag started with $input'),
      logSuccess: (duration, output) =>
          logSuccess('$tag completed after $duration with $output'),
      logError: (duration, exception) =>
          logError('$tag failed after $duration with $exception'),
    );
  }
}
