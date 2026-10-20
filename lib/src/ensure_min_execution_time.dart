import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

Future<void> _waitForMinimum(
  Stopwatch stopwatch,
  Duration duration,
  FutureOr<void> Function(Duration elapsed)? onDelay,
) async {
  final delayTime = duration - stopwatch.elapsed;
  if (delayTime > Duration.zero) {
    while (stopwatch.elapsed < duration) {
      await Future.delayed(duration - stopwatch.elapsed);
    }
    await onDelay?.call(delayTime);
  }
}

extension EnsureMinExecutionTimeExt<Input, Output>
    on InteractorContract<Input, Output> {
  /// Delays completion to meet [duration], including after an exception.
  ParameterizedResultInteractor<Input, Output> ensureMinExecutionTime(
    Duration duration, {
    FutureOr<void> Function(Duration elapsed)? onDelay,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      try {
        return await invoke(input);
      } finally {
        await _waitForMinimum(stopwatch, duration, onDelay);
      }
    });
  }

  /// Delays successful completion to meet [duration].
  ParameterizedResultInteractor<Input, Output> ensureMinExecutionTimeOnSuccess(
    Duration duration, {
    FutureOr<void> Function(Duration elapsed)? onDelay,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch()..start();
      final output = await invoke(input);
      await _waitForMinimum(stopwatch, duration, onDelay);
      return output;
    });
  }
}
