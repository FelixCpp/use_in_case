import 'package:uic_interactor/src/modifiers/busy_state/busy_state_modifier.dart';
import 'package:uic_interactor/src/modifiers/busy_state/listener/busy_state_listener.dart';
import 'package:uic_interactor/uic_interactor.dart';

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

extension InvocationConfiguratorWithBusyState<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> listenOnBusyState(
    BusyStateListener listener,
  ) {
    return modifier(
      BusyStateListenerModifierBuilder(
        onEvent: (event) {
          event.when(
            onStart: (_) => listener.addLoader(),
            onSuccess: (_) => listener.removeLoader(),
            onFailure: (_) => listener.removeLoader(),
          );
        },
      ),
    );
  }

  InvocationConfigurator<Input, Output> receiveBusyStateChange(
    void Function(bool isBusy) receiver,
  ) {
    return modifier(
      BusyStateListenerModifierBuilder(
        onEvent: (event) {
          event.when(
            onStart: (_) => receiver(true),
            onSuccess: (_) => receiver(false),
            onFailure: (_) => receiver(false),
          );
        },
      ),
    );
  }
}
