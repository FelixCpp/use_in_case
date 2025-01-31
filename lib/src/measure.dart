import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension Measure<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Measures the time it takes to run the interactor.
  /// [callback] will be invoked regardless of the interactor's success or failure.
  ///
  /// For example:
  /// ```dart
  /// myInteractor
  ///   .measure((elapsed) => println('Elapsed Duration: $elapsed')
  ///   .run(input);
  /// ```
  ParameterizedResultInteractor<Input, Output> measure(
    FutureOr<void> Function(Duration) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      try {
        final output = await runUnsafe(input);
        await callback(stopwatch.elapsed);
        return output;
      } finally {
        await callback(stopwatch.elapsed);
      }
    });
  }

  /// Measures the time it takes to run the interactor.
  /// Instead of passing in a callback to get the elapsed time it took to
  /// invoke the interactor, this method returns a tuple of the elapsed time
  /// and the output of the interactor.
  ///
  /// For example:
  /// ```dart
  /// final (elapsedTime, result) = await myInteractor
  ///   .measuredValue()
  ///   .getOrThrow(input);
  ///
  /// print('Elapsed Duration: $elapsed');
  /// print('Result: $result');
  /// ```
  ParameterizedResultInteractor<Input, (Duration, Output)> measuredValue() {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      final output = await runUnsafe(input);
      return (stopwatch.elapsed, output);
    });
  }
}
