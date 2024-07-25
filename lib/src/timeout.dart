import 'package:use_in_case/src/interactor.dart';

extension Timeout<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> timeout(
    Duration duration,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return execute(input).timeout(duration);
    });
  }
}
