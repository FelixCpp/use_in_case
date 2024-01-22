import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_listener.dart';
import 'package:uic_interactor_execution_listener/src/modifiers/exeuction_listener_modifier.dart';

extension InvocationConfiguratorWithExecutionListener<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> publishTo(
    InteractorExecutionListener listener,
  ) {
    return InvocationConfigurator(
      details: details,
      modifier: ExecutionListenerModifier(
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

  InvocationConfigurator<Input, Output> publishInto(
    void Function(bool isBusy) listener,
  ) {
    return InvocationConfigurator(
      details: details,
      modifier: ExecutionListenerModifier(
        onEvent: (event) {
          event.when(
            onStart: (_) => listener(true),
            onSuccess: (_) => listener(false),
            onFailure: (_) => listener(false),
          );
        },
        modifier: modifier,
      ),
    );
  }
}
