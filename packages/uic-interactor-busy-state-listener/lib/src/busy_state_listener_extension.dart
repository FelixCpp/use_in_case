import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state_listener/src/modifiers/busy_state_listener_modifier.dart';
import 'package:uic_interactor_busy_state_listener/uic_interactor_busy_state_listener.dart';

extension InvocationConfiguratorWithExecutionListener<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> listenOnBusyState(
    BusyStateListener listener,
  ) {
    return apply(
      (modifier) => BusyStateListenerModifier(
        onEvent: (event) {
          event.when(
            onStart: (_) => listener.addLoader(),
            onSuccess: (_) => listener.removeLoader(),
            onFailure: (_) => listener.removeLoader(),
          );
        },
        modifier: modifier,
      ),
    );
  }

  InvocationConfigurator<Input, Output> receiveBusyStateChange(
    void Function(bool isBusy) receiver,
  ) {
    return apply(
      (modifier) => BusyStateListenerModifier(
        onEvent: (event) {
          event.when(
            onStart: (_) => receiver(true),
            onSuccess: (_) => receiver(false),
            onFailure: (_) => receiver(false),
          );
        },
        modifier: modifier,
      ),
    );
  }
}
