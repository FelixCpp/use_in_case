import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_busy_state/uic_interactor_busy_state.dart';

extension InvocationConfiguratorWithListener<Input, Output>
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
}
