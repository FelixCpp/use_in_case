import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Extension that adds the `intercept` method to the [ParameterizedResultInteractor] class.
/// This method allows you to intercept exceptions thrown by the interactor's [execute] method.
/// The callback will be called with the exception that was thrown.
/// The exception will be rethrown after the callback has been executed.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///  .intercept((exception) => print('Exception: $exception'))
///   .run(input);
/// ```
///
/// You can also specify the type of exception you want to intercept:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///  .typedIntercept<FormatException>((exception) => print('Exception: $exception'))
///  .run(input);
/// ```
extension Intercept<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Intercepts exceptions thrown by the interactor's [execute] method.
  ///
  /// See also: [typedIntercept]
  ParameterizedResultInteractor<Input, Output> intercept(
    FutureOr<void> Function(Exception) callback,
  ) {
    return typedIntercept<Exception>(callback);
  }

  /// Intercepts exceptions of a specific type thrown by the interactor's [execute] method.
  ///
  /// See also: [intercept]
  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    FutureOr<void> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return Future(() => execute(input))
          .onError<ExceptionType>((exception, _) {
        callback(exception);
        throw exception;
      });
    });
  }
}
