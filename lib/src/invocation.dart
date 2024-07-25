import 'package:use_in_case/use_in_case.dart';

extension Invocation<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  Future<void> runUnsafe(Input input) {
    return execute(input);
  }

  Future<void> run(Input input) async {
    execute(input).catchError((_, __) {});
  }
}
