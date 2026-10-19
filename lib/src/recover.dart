import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

FutureOr<Output> _recover<Output>(
  FutureOr<Output> Function() execute,
  FutureOr<Output> Function(Exception) callback,
  FutureOr<bool> Function(Exception) predicate,
) async {
  try {
    return await execute();
  } on Exception catch (exception) {
    if (await predicate(exception)) {
      return callback(exception);
    }
    rethrow;
  }
}

extension RecoverExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Recovers from exceptions matching [predicate].
  ParameterizedResultInteractor<Input, Output> checkedRecover(
    FutureOr<Output> Function(Exception) callback,
    FutureOr<bool> Function(Exception) predicate,
  ) {
    return InlinedParameterizedResultInteractor(
      (input) => _recover(() => invoke(input), callback, predicate),
    );
  }

  /// Recovers only from exceptions matching [ExceptionType].
  ParameterizedResultInteractor<Input, Output>
      typedRecover<ExceptionType extends Exception>(
    FutureOr<Output> Function(ExceptionType) callback,
  ) =>
          checkedRecover(
            (exception) => callback(exception as ExceptionType),
            (exception) => exception is ExceptionType,
          );

  /// Recovers from any [Exception].
  ParameterizedResultInteractor<Input, Output> recover(
    FutureOr<Output> Function(Exception) callback,
  ) =>
      typedRecover<Exception>((exception) => callback(exception));
}
