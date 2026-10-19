import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Adds logging callbacks around interactor invocations.
extension LogExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> logEvents({
    required FutureOr<void> Function(Input) logStart,
    required FutureOr<void> Function(Duration, Output) logSuccess,
    required FutureOr<void> Function(Duration, Exception) logError,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      try {
        await logStart(input);
        final output = await invoke(input);
        await logSuccess(stopwatch.elapsed, output);
        return output;
      } on Exception catch (exception) {
        await logError(stopwatch.elapsed, exception);
        rethrow;
      }
    });
  }

  /// Logs invocation events using messages prefixed with [tag].
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
