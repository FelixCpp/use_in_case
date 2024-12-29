import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension Recover<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> recover(
    FutureOr<Output> Function(Exception) callback,
  ) {
    return typedRecover<Exception>(callback);
  }

  ParameterizedResultInteractor<Input, Output>
      typedRecover<ExceptionType extends Exception>(
    FutureOr<Output> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return await execute(input);
      } on ExceptionType catch (exception) {
        return callback(exception);
      }
    });
  }
}
