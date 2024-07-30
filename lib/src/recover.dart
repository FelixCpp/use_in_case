import 'package:use_in_case/src/interactor.dart';

extension Recover<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> recover(
    Future<Output> Function(Exception) callback,
  ) {
    return typedRecover<Exception>(callback);
  }

  ParameterizedResultInteractor<Input, Output>
      typedRecover<ExceptionType extends Exception>(
    Future<Output> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return execute(input).onError(
        (ExceptionType exception, _) {
          return callback(exception);
        },
        test: (error) => error is ExceptionType,
      );
    });
  }
}
