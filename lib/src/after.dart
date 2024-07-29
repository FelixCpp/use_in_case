import 'package:use_in_case/src/interactor.dart';

extension After<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> after(
    Future<void> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return execute(input).then((output) async {
        await callback(output);
        return output;
      });
    });
  }
}
