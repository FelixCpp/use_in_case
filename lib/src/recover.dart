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
    Future<Output> Function(Exception) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return execute(input);
      } on ExceptionType catch (exception) {
        return callback(exception);
      }
    });
  }
}
