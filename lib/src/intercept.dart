import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Extension that adds the `intercept` method to the [ParameterizedResultInteractor] class.
/// This method allows you to intercept exceptions thrown by the interactor's [getOrThrow] method.
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
///
/// It is also possible to intercept exceptions based on a predicate:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .checkedIntercept(
///   (exception) => print('FormatException: $exception'),
///   (exception) => exception is FormatException,
/// ).run(input);
/// ```
extension InterceptExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Intercepts exceptions thrown by the interactor's [getOrThrow] method.
  /// [callback] will only be invoked when the [predicate] returned `true`.
  ///
  /// See also: [typedIntercept], [intercept]
  ParameterizedResultInteractor<Input, Output> checkedIntercept(
    FutureOr<void> Function(Exception) callback,
    FutureOr<bool> Function(Exception) predicate,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return await getOrThrow(input);
      } on Exception catch (exception) {
        if (await predicate(exception)) {
          callback(exception);
        }

        rethrow;
      }
    });
  }

  /// Intercepts exceptions of a specific type thrown by the interactor's [getOrThrow] method.
  ///
  /// See also: [intercept]
  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    FutureOr<void> Function(ExceptionType) callback,
  ) {
    return checkedIntercept(
      (exception) => callback(exception as ExceptionType),
      (exception) => exception is ExceptionType,
    );
  }

  /// Intercepts exceptions thrown by the interactor's [getOrThrow] method.
  ///
  /// See also: [typedIntercept]
  ParameterizedResultInteractor<Input, Output> intercept(
    FutureOr<void> Function(Exception) callback,
  ) {
    return typedIntercept<Exception>(callback);
  }
}
