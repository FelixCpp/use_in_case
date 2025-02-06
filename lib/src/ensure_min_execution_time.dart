import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension EnsureMinExecutionTimeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Runs the interactor for at least [duration] before returning.
  /// If the interactor finishes before [duration], it will wait for the remaining time.
  /// Otherwise, it will return immediately.
  ///
  /// Optionally, you can provide a callback [onDelay] that will be called with the time that was waited.
  /// Note that this callback is called after the required duration to wait has passed.
  ///
  /// This method does wait the required amount of time reguardless of whether the interactor
  /// failed due to an exception or not. For a method that only waits on success, see [ensureMinExecutionTimeOnSuccess].
  ///
  /// For example:
  /// ```dart
  /// await myInteractor
  ///   .ensureMinExecutionTime(Duration(milliseconds: 100))
  ///   .run(input);
  /// ```
  ///
  /// An example using the [onDelay] callback:
  /// ```dart
  /// await myInteractor
  ///   .ensureMinExecutionTime(
  ///     Duration(milliseconds: 100),
  ///     onDelay: (elapsed) => print('Waited for $elapsed'),
  ///   ).run(input);
  /// ```
  ///
  /// See: [ensureMinExecutionTimeOnSuccess]
  ParameterizedResultInteractor<Input, Output> ensureMinExecutionTime(
    Duration duration, {
    FutureOr<void> Function(Duration elapsed)? onDelay,
  }) {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start()).eventually(() async {
      final delayTime = duration - stopwatch.elapsed;
      if (delayTime <= Duration.zero) return;

      await Future.delayed(delayTime);

      if (onDelay != null) {
        await onDelay(delayTime);
      }
    });
  }

  /// Runs the interactor for at least [duration] before returning.
  /// If the interactor finishes before [duration], it will wait for the remaining time.
  /// Otherwise, it will return immediately.
  ///
  /// Optionally, you can provide a callback [onDelay] that will be called with the time that was waited.
  /// Note that this callback is called after the required duration to wait has passed.
  ///
  /// This method only waits if the interactor finishes successfully. If the interactor fails due to an exception,
  /// it will return immediately. For a method that waits regardless of the interactor's success or failure,
  /// see [ensureMinExecutionTime].
  ///
  /// For example:
  /// ```dart
  /// await myInteractor
  ///   .ensureMinExecutionTimeOnSuccess(Duration(milliseconds: 100))
  ///   .run(input);
  /// ```
  ///
  /// An example using the [onDelay] callback:
  /// ```dart
  /// await myInteractor
  ///   .ensureMinExecutionTimeOnSuccess(
  ///     Duration(milliseconds: 100),
  ///     onDelay: (elapsed) => print('Waited for $elapsed'),
  /// ).run(input);
  /// ```
  ///
  /// See [ensureMinExecutionTime]
  ParameterizedResultInteractor<Input, Output> ensureMinExecutionTimeOnSuccess(
    Duration duration, {
    FutureOr<void> Function(Duration elapsed)? onDelay,
  }) {
    final stopwatch = Stopwatch();

    return before((_) => stopwatch.start()).after((output) async {
      final delayTime = duration - stopwatch.elapsed;
      if (delayTime <= Duration.zero) return;

      await Future.delayed(delayTime);

      if (onDelay != null) {
        await onDelay(delayTime);
      }
    });
  }
}
