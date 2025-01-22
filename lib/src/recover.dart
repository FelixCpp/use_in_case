import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Adds the `recover` method to the [ParameterizedResultInteractor] class.
/// This method allows you to recover from an exception thrown by the interactor's [runUnsafe] method.
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
///
/// It is also possible to recover from exceptions based on a predicate:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///  .checkedRecover(
///     (exception) => 'Recovered from: $exception',
///     (exception) => exception is FormatException,
///   ).run(input);
extension Recover<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  /// This method allows you to recover from an exception thrown by the interactor's [runUnsafe] method.
  /// Only exceptions that which the [predicate] returns `true` will be recovered from.
  ///
  /// [callback] The callback to invoke when [predicate] returned `true` for the given [Exception].
  /// [predicate] The predicate to invoke to determine if the given [Exception] should be recovered from.
  ///
  /// See also: [typedRecover], [recover]
  ParameterizedResultInteractor<Input, Output> checkedRecover(
    FutureOr<Output> Function(Exception) callback,
    FutureOr<bool> Function(Exception) predicate,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return await runUnsafe(input);
      } on Exception catch (exception) {
        if (await predicate(exception)) {
          return callback(exception);
        }

        rethrow;
      }
    });
  }

  /// This method allows you to recover from an [Exception] of a specific type thrown by the interactor's [runUnsafe] method.
  ///
  /// [callback] The callback to invoke when an [Exception] of type [ExceptionType] was thrown.
  ///
  /// See also: [checkedRecover], [recover]
  ParameterizedResultInteractor<Input, Output> typedRecover<ExceptionType extends Exception>(
    FutureOr<Output> Function(ExceptionType) callback,
  ) {
    return checkedRecover(
      (exception) => callback(exception as ExceptionType),
      (exception) => exception is ExceptionType,
    );
  }

  /// This method allows you to recover from any [Exception] thrown by the interactor's [runUnsafe] method.
  ///
  /// [callback] The callback to invoke when an [Exception] was thrown.
  ///
  /// See also: [typedRecover], [checkedRecover]
  ParameterizedResultInteractor<Input, Output> recover(FutureOr<Output> Function(Exception) callback) {
    return typedRecover<Exception>((exception) => callback(exception));
  }
}
