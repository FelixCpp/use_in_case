import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Extension that adds the `timeout` method to the [ParameterizedResultInteractor] class.
/// This method allows you to specify a timeout for the interactor's [execute] method.
/// If the interactor takes longer than the specified duration, a [TimeoutException] will be thrown.
/// You can also specify a custom error message for the [TimeoutException].
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .timeout(Duration(seconds: 5), errorMessage: () => 'The interactor took too long to complete.')
///   .run(input);
/// ```
extension Timeout<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> timeout(
    Duration duration, {
    String? Function()? errorMessage,
  }) {
    return InlinedParameterizedResultInteractor((input) {
      return Future<Output>(() => execute(input)).timeout(
        duration,
        onTimeout: () {
          final message = errorMessage?.call();
          throw TimeoutException(message, duration);
        },
      );
    });
  }
}
