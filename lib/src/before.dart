import 'package:use_in_case/src/interactor.dart';

extension Before<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> before(
    Future<void> Function(Input) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return callback(input).then((_) => execute(input));
    });
  }
}
