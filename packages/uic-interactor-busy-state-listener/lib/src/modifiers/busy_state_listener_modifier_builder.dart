import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state_listener/src/modifiers/busy_state_listener_modifier.dart';

class BusyStateListenerModifierBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final void Function(InvocationEvent<Input, Output>) onEvent;
  const BusyStateListenerModifierBuilder({required this.onEvent});

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return BusyStateListenerModifier(
      modifier: modifier,
      onEvent: onEvent,
    );
  }
}
