import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension Intercept<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> intercept(
    FutureOr<void> Function(Exception) callback,
  ) {
    return typedIntercept<Exception>(callback);
  }

  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    FutureOr<void> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return await execute(input);
      } on ExceptionType catch (exception) {
        await callback(exception);
        rethrow;
      }
    });
  }
}
