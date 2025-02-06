import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

typedef TimedValue<Output> = (
  Duration duration,
  Output value,
);

/// This extension provides methods to measure the time it takes to run an interactor.
///
/// Provided methods:
///   - [measureTime]
///   - [measureTimeOnSuccess]
///   - [measureTimedValue]
extension MeasureTimeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// This method measures the time it takes to run the interactor.
  /// When finished raguardless of whether the invocation
  /// threw an exception or not, [callback] is being called with
  /// the amount of time it took to run the interactor.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .measureTime((elapsed) => print('Elapsed time: $elapsed'))
  ///   .run(input);
  /// ```
  ///
  /// If you want to execute the given [callback] only when the interactor
  /// finishes successfully, you can use the [measureTimeOnSuccess] method.
  ///
  /// Sometimes you might want to map the output to include the duration
  /// it took in order to perform the invocation for further processing.
  /// In this case, you can use the [measureTimedValue] method.
  ///
  /// see [measureTimeOnSuccess], [measureTimedValue]
  ParameterizedResultInteractor<Input, Output> measureTime(
    FutureOr<void> Function(Duration) callback,
  ) {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start())
        .eventually(() => callback(stopwatch.elapsed));
  }

  /// This method measures the time it takes to run the interactor.
  /// When the interactor finishes successfully, [callback] is being called
  /// with the amount of time it took to run the interactor and the produced
  /// output.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .measureTimeOnSuccess((elapsed, output) => print('Elapsed time: $elapsed, Output: $output'))
  ///   .run(input);
  /// ```
  ///
  /// If you want to measure the time it took to run the interactor
  /// regardless of the outcome, you can use the [measureTime] method.
  ///
  /// Sometimes you might want to map the output to include the duration
  /// it took in order to perform the invocation for further processing.
  /// In this case, you can use the [measureTimedValue] method.
  ///
  /// see [measureTime], [measureTimedValue]
  ParameterizedResultInteractor<Input, Output> measureTimeOnSuccess(
    FutureOr<void> Function(Duration, Output) callback,
  ) {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start())
        .after((output) => callback(stopwatch.elapsed, output));
  }

  /// This method measures the time it takes to run the interactor and
  /// maps the output to include the duration it took in order to perform
  /// the invocation.
  ///
  /// The output will be a tuple of the duration and the original output where
  /// the first element is the duration and the second element is the original
  /// output of the interactor.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// final result = await interactor
  ///   .measureTimedValue()
  ///   .run(input);
  ///
  /// print('Elapsed time: ${result.$1}');
  /// print('Output: ${result.$2}');
  /// ```
  ///
  /// Note that this only works, if the interactor finished successfully.
  ///
  /// If you want to measure the time it took to run the interactor without
  /// changing the output, you can use the [measureTime] or [measureTimeOnSuccess]
  /// methods.
  ///
  /// see [measureTime], [measureTimeOnSuccess]
  ParameterizedResultInteractor<Input, TimedValue<Output>> measureTimedValue() {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start())
        .map((output) => (stopwatch.elapsed, output));
  }
}
