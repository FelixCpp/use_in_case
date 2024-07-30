import 'package:use_in_case/src/interactor.dart';

extension Intercept<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> intercept(
    Future<void> Function(Exception) callback,
  ) {
    return typedIntercept<Exception>(callback);
  }

  ParameterizedResultInteractor<Input, Output>
      typedIntercept<ExceptionType extends Exception>(
    Future<void> Function(ExceptionType) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return execute(input).onError((ExceptionType exception, _) {
        callback(exception);
        return Future<Output>.error(exception);
      }, test: (error) => error is ExceptionType);
    });
  }
}
