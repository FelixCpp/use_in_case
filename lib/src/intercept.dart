import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Exception that gets thrown when an exception has already
/// been handled in the [checkedIntercept] method.
///
/// We need this exception to be able to determine whether
/// the caller has already handled the exception or not.
final class HandledException<ExceptionType extends Exception>
    implements Exception {
  final ExceptionType exception;
  const HandledException(this.exception);
}

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
  /// [handled] specifies whether the exception should be rethrown
  /// after the callback has been executed or not. If set to `false`, the
  /// exception won't be caught again by the [checkedIntercept] method.
  ///
  /// Demonstrating the use of [handled]:
  ///
  /// ```dart
  /// final interactor = MyInteractor();
  ///
  /// await interactor
  ///   .checkedIntercept(
  ///     (exception) => print('Exception: $exception'),
  ///     (exception) => exception is FormatException,
  ///     handled: false,
  ///   )
  ///   .checkedIntercept(
  ///     (exception) => print('FormatException: $exception'),
  ///     (exception) => exception is FormatException,
  ///     handled: false,
  ///   )
  ///   .run(input);
  /// ```
  ///
  /// The output of the code above will result in calling both callbacks
  /// since the same exception is rethrown right after the first interception.
  /// Setting the `allowMultiCatch` parameter to `false` will prevent all
  /// following interception modifiers from receiving the same exception
  /// resulting in only the first callback being called.
  ///
  /// In case [handled] is enabled, the exception will be rethrown as a
  /// [HandledException] with the original exception as its type parameter. This
  /// means that the resulting exception will be of type `HandledException<Exception>`.
  /// This is necessary to differentiate between exceptions that have been handled
  /// and those that haven't.
  ///
  /// If you want to intercept exceptions of a specific type, you should use
  /// the [typedIntercept] method instead of this one. Rather than loosing the
  /// type information of the exception [getOrThrow] has generated, it will
  /// be preserved and associated with the [HandledException].
  ///
  /// See also: [typedIntercept], [intercept]
  ParameterizedResultInteractor<Input, Output> checkedIntercept(
    FutureOr<void> Function(Exception) callback,
    FutureOr<bool> Function(Exception) predicate, {
    bool handled = false,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return await getOrThrow(input);
      } on HandledException {
        // ignore the exception since it has been handled
        // earlier.
        rethrow;
      } on Exception catch (exception) {
        if (await predicate(exception)) {
          await callback(exception);

          // We're not allowed to catch the exception
          // later again, so we throw a special exception
          // that we can differentiate from others.
          //
          // In this scenario, we don't have enough type
          // information to determine the exact type of
          // the exception, so we just throw it as a
          // HandledException<Exception>.
          if (handled) {
            throw HandledException(exception);
          }
        }

        rethrow;
      }
    });
  }

  /// Intercepts exceptions of a specific type thrown by the interactor's [getOrThrow] method.
  /// [callback] will only be invoked when the exception is of the specified [ExceptionType].
  /// [handled] specifies whether the exception should be rethrown and therefore
  /// caught by any chained [checkedIntercept] method or not. More details can be found in the
  /// documentation of the [checkedIntercept] method.
  ///
  /// This method internally uses the [typedIntercept] method, which delegates
  /// its work to [checkedIntercept].
  ///
  /// See also: [intercept], [checkedIntercept]
  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    FutureOr<void> Function(ExceptionType) callback, {
    bool handled = false,
  }) {
    return checkedIntercept(
      (exception) async {
        await callback(exception as ExceptionType);

        // Make sure to rethrow the exception if we're not
        // allowed to catch it again. It's important to
        // specify the type of the original exception to
        // provide the correct type to the HandledException.
        //
        // If we wouldn't do this, the exception would be
        // rethrown as a HandledException<Exception> without
        // concrete exception type.
        if (handled) {
          throw HandledException(exception);
        }
      },
      (exception) async => exception is ExceptionType,
      handled: handled, //!< This parameter is useless here
    );
  }

  /// Intercepts exceptions thrown by the interactor's [getOrThrow] method.
  /// [callback] will be called any time an exception occurs.
  /// [handled] specifies whether the exception should be rethrown and therefore
  /// caught by any chained [checkedIntercept] method or not. More details can be found in the
  /// documentation of the [checkedIntercept] method.
  ///
  /// This method internally uses the [typedIntercept] method, which delegates
  /// its work to [checkedIntercept].
  ///
  /// See also: [typedIntercept], [checkedIntercept]
  ParameterizedResultInteractor<Input, Output> intercept(
    FutureOr<void> Function(Exception) callback, {
    bool handled = false,
  }) {
    return typedIntercept<Exception>(
      callback,
      handled: handled,
    );
  }
}
