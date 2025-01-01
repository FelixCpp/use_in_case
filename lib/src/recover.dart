import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Adds the `recover` method to the [ParameterizedResultInteractor] class.
/// This method allows you to recover from an exception thrown by the interactor's [execute] method.
/// The callback will be called with the exception that was thrown.
/// The result of the callback will be returned instead of the exception.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .recover((exception) => 'Recovered from: $exception')
///   .run(input);
/// ```
///
/// You can also specify the type of exception you want to recover from:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .typedRecover<FormatException>((exception) => 'Recovered from: $exception')
///   .run(input);
/// ```
extension Recover<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Recovers from an exception thrown by the interactor's [execute] method.
  ///
  /// See also: [typedRecover]
  ParameterizedResultInteractor<Input, Output> recover(
    FutureOr<Output> Function(Exception) callback,
  ) {
    return typedRecover<Exception>(callback);
  }

  /// Recovers from an exception of a specific type thrown by the interactor's [execute] method.
  ///
  /// See also: [recover]
  ParameterizedResultInteractor<Input, Output>
      typedRecover<ExceptionType extends Exception>(
    FutureOr<Output> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      return Future(() => execute(input))
          .onError<ExceptionType>((exception, _) => callback(exception));
    });
  }
}
