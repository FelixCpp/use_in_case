import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension MeasureTimeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Measures the time it takes to run the interactor.
  /// [callback] will be invoked regardless of the interactor's success or failure.
  ///
  /// For example:
  /// ```dart
  /// myInteractor
  ///   .measureTime((elapsed) => println('Elapsed Duration: $elapsed')
  ///   .run(input);
  /// ```
  ParameterizedResultInteractor<Input, Output> measureTime(
    FutureOr<void> Function(Duration) callback,
  ) {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start())
        .eventually(() => callback(stopwatch.elapsed));
  }

  /// Measures the time it takes to run the interactor.
  /// Instead of passing in a callback to get the elapsed time it took to
  /// invoke the interactor, this method returns a tuple of the elapsed time
  /// and the output of the interactor.
  ///
  /// For example:
  /// ```dart
  /// final (elapsedTime, result) = await myInteractor
  ///   .measureTimedValue()
  ///   .getOrThrow(input);
  ///
  /// print('Elapsed Duration: $elapsed');
  /// print('Result: $result');
  /// ```
  ParameterizedResultInteractor<Input, (Duration, Output)> measureTimedValue() {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start())
        .map((output) => (stopwatch.elapsed, output));
  }
}
