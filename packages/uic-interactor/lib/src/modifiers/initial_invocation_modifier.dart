import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';
import 'package:uic_interactor/src/parameterized_result_interactor.dart';

class InitialInvocationModifier<Input, Output> implements InvocationModifier {
  final Input _input;
  final ParameterizedResultInteractor<Input, Output> _interactor;

  const InitialInvocationModifier({
    required Input input,
    required ParameterizedResultInteractor<Input, Output> interactor,
  })  : _input = input,
        _interactor = interactor;

  @override
  Stream<InvocationEvent> buildStream() async* {
    try {
      yield InvocationEvent.onStart(_input);
      yield InvocationEvent.onSuccess(await _interactor.execute(_input));
    } on Exception catch (exception) {
      yield InvocationEvent.onFailure(exception);
    }
  }
}
