import 'package:uic_interactor/src/configured_invocation.dart';
import 'package:uic_interactor/src/modifiers/initial_invocation_modifier.dart';
import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';
import 'package:uic_interactor/src/modifiers/timeout_invocation_modifier.dart';
import 'package:uic_interactor/uic_interactor.dart';

class InvocationConfigurator<Modifier extends InvocationModifier> {
  final Modifier _modifier;

  const InvocationConfigurator({
    required Modifier modifier,
  }) : _modifier = modifier;

  InvocationConfigurator<TimeoutInvocationModifier<Modifier>> timeout(
    Duration timeoutDuration, {
    String? message,
  }) {
    return InvocationConfigurator(
      modifier: TimeoutInvocationModifier(
        timeoutDuration: timeoutDuration,
        modifier: _modifier,
        message: message,
      ),
    );
  }

  ConfiguredInvocation<Modifier> configure(
    void Function(InvocationEvent) onEvent,
  ) {
    return ConfiguredInvocation(
      onEvent: onEvent,
      modifier: _modifier,
    );
  }
}

extension InvokeInteractorExtension<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  InvocationConfigurator<InitialInvocationModifier<Input, Output>> call(
    Input input,
  ) {
    return InvocationConfigurator(
      modifier: InitialInvocationModifier(input: input, interactor: this),
    );
  }
}
