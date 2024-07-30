import 'package:use_in_case/use_in_case.dart';

extension Map<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, NewOutput> map<NewOutput>(
    Future<NewOutput> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor<Input, NewOutput>((input) {
      return execute(input).then((output) => callback(output));
    });
  }
}
