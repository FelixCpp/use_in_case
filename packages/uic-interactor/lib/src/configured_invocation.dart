import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class ConfiguredInvocation<Input, Output,
    Modifier extends InvocationModifier<Input, Output>> {
  final void Function(InvocationEvent<Input, Output>) _onEvent;
  final Modifier _modifier;

  const ConfiguredInvocation({
    required void Function(InvocationEvent<Input, Output>) onEvent,
    required Modifier modifier,
  })  : _onEvent = onEvent,
        _modifier = modifier;

  void run() {
    _modifier.buildStream().listen(
          _onEvent,
          cancelOnError: true,
        );
  }
}
