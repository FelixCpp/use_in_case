import 'package:use_in_case/src/interactor.dart';

extension Catch<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> catchException(
    Future<void> Function(Exception) callback,
  ) {
    return catchTypedException<Exception>(callback);
  }

  ParameterizedResultInteractor<Input, Output>
      catchTypedException<ExceptionType extends Exception>(
    Future<void> Function(Exception) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        return execute(input);
      } on ExceptionType catch (exception) {
        callback(exception);
        rethrow;
      }
    });
  }
}
