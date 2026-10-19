import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

typedef TimedValue<Output> = (Duration duration, Output value);

/// Adds per-invocation timing operations to interactors.
extension MeasureTimeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Measures each invocation and invokes [callback] even if it fails.
  ParameterizedResultInteractor<Input, Output> measureTime(
    FutureOr<void> Function(Duration) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      try {
        return await invoke(input);
      } finally {
        await callback(stopwatch.elapsed);
      }
    });
  }

  /// Measures a successful invocation and provides its output.
  ParameterizedResultInteractor<Input, Output> measureTimeOnSuccess(
    FutureOr<void> Function(Duration, Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      final output = await invoke(input);
      await callback(stopwatch.elapsed, output);
      return output;
    });
  }

  /// Returns the successful output together with its elapsed time.
  ParameterizedResultInteractor<Input, TimedValue<Output>>
      measureTimedValueOnSuccess() {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      final output = await invoke(input);
      return (stopwatch.elapsed, output);
    });
  }

  /// Returns elapsed time and a nullable output, including on Exception.
  ParameterizedResultInteractor<Input, TimedValue<Output?>>
      measureTimedValue() {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      try {
        final output = await invoke(input);
        return (stopwatch.elapsed, output);
      } on Exception {
        return (stopwatch.elapsed, null);
      }
    });
  }
}
