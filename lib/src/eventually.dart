import 'package:use_in_case/src/interactor.dart';

extension Eventually<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> eventually(
    Future<void> Function() callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return execute(input).whenComplete(callback);
    });
  }
}
