import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state/src/modifier/busy_state_modifier_builder.dart';

extension InvocationConfiguratorWithBusyStateReceiver<Input, Output>
    on InvocationConfigurator<Input, Output> {
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
