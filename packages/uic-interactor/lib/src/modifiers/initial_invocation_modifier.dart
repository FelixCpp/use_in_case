import 'dart:async';

import 'package:uic_interactor/src/invocation_event_handler.dart';
import 'package:uic_interactor/src/util/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';
import 'package:uic_interactor/src/parameterized_result_interactor.dart';

class InitialInvocationModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final Input _input;
  final ParameterizedResultInteractor<Input, Output> _interactor;

  const InitialInvocationModifier({
    required Input input,
    required ParameterizedResultInteractor<Input, Output> interactor,
  })  : _input = input,
        _interactor = interactor;

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() async* {
    try {
      yield InvocationEvent.onStart(_input);
      yield InvocationEvent.onSuccess(await _interactor.execute(_input));
    } on Exception catch (exception) {
      yield InvocationEvent.onFailure(exception);
    }
  }

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return (event, details) => callback(event, details);
  }
}
