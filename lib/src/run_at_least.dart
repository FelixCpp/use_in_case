import 'package:use_in_case/use_in_case.dart';

extension RunAtLeast<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Runs the interactor for at least [duration] before returning.
  /// If the interactor finishes before [duration], it will wait for the remaining time.
  /// Otherwise, it will return immediately.
  ///
  /// For example:
  /// ```dart
  /// await myInteractor
  ///   .runAtLeast(Duration(milliseconds: 100))
  ///   .run(input);
  /// ```
  ///
  /// See: [measure]
  ParameterizedResultInteractor<Input, Output> runAtLeast(Duration duration) {
    return measure((elapsed) async {
      if (elapsed < duration) {
        await Future.delayed(duration - elapsed);
      }
    });
  }
}
