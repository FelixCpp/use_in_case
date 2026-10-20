import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Marks an exception that an interception modifier has already consumed.
final class HandledException<ExceptionType extends Exception>
    implements Exception {
  final ExceptionType exception;
  const HandledException(this.exception);
}

FutureOr<Output> _checkedIntercept<Output>(
  FutureOr<Output> Function() execute,
  FutureOr<void> Function(Exception) callback,
  FutureOr<bool> Function(Exception) predicate, {
  required bool consume,
}) async {
  try {
    return await execute();
  } on HandledException {
    rethrow;
  } on Exception catch (exception) {
    if (await predicate(exception)) {
      await callback(exception);
      if (consume) {
        throw HandledException(exception);
      }
    }
    rethrow;
  }
}

/// Adds exception interception to interactor invocations.
extension InterceptExt<Input, Output> on InteractorContract<Input, Output> {
  /// Observes matching exceptions and optionally consumes them.
  ParameterizedResultInteractor<Input, Output> checkedIntercept(
    FutureOr<void> Function(Exception) callback,
    FutureOr<bool> Function(Exception) predicate, {
    bool consume = true,
  }) {
    return InlinedParameterizedResultInteractor(
      (input) => _checkedIntercept(
        () => invoke(input),
        callback,
        predicate,
        consume: consume,
      ),
    );
  }

  /// Observes exceptions matching [ExceptionType].
  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    FutureOr<void> Function(ExceptionType) callback, {
    bool consume = true,
  }) {
    return checkedIntercept(
      (exception) async {
        await callback(exception as ExceptionType);
        if (consume) {
          throw HandledException(exception);
        }
      },
      (exception) => exception is ExceptionType,
      consume: false,
    );
  }

  /// Observes any [Exception].
  ParameterizedResultInteractor<Input, Output> intercept(
    FutureOr<void> Function(Exception) callback, {
    bool consume = true,
  }) =>
      typedIntercept<Exception>(callback, consume: consume);
}
