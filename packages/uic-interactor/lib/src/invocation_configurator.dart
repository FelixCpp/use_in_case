import 'dart:async';

import 'package:uic_interactor/src/configured_invocation.dart';
import 'package:uic_interactor/src/modifiers/initial_invocation_modifier.dart';
import 'package:uic_interactor/src/modifiers/timeout_invocation_modifier.dart';
import 'package:uic_interactor/uic_interactor.dart';

class InvocationConfigurator<Input, Output,
    Modifier extends InvocationModifier<Input, Output>> {
  final InvocationDetails details;
  final Modifier modifier;

  const InvocationConfigurator({
    required this.details,
    required this.modifier,
  });

  Future<Output> get() {
    final completer = Completer<Output>();

    configure((event) {
      event.whenOrNull(
        onSuccess: (output) => completer.complete(output),
        onFailure: (exception) => completer.completeError(exception),
      );
    }).run();

    return completer.future;
  }

  Future<Output?> getOrNull() {
    return get()
        .then((value) => Future<Output?>.value(value))
        .catchError((_) => Future<Output?>.value());
  }

  Future<Output> getOrElse({required Output fallback}) {
    return get().catchError((_) => fallback);
  }

  ConfiguredInvocation<Input, Output, Modifier> configure(
    void Function(InvocationEvent<Input, Output>) onEvent,
  ) {
    return ConfiguredInvocation(
      details: details,
      onEvent: onEvent,
      modifier: modifier,
    );
  }
}

///
/// Timeout addon
///

extension InvocationConfiguratorWithTimeout<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    on InvocationConfigurator<Input, Output, Modifier> {
  InvocationConfigurator<Input, Output,
      TimeoutInvocationModifier<Input, Output, Modifier>> timeout(
    Duration timeoutDuration, {
    String? message,
  }) {
    return InvocationConfigurator(
      details: details,
      modifier: TimeoutInvocationModifier(
        timeoutDuration: timeoutDuration,
        modifier: modifier,
        message: message,
      ),
    );
  }
}

///
/// Invocable Interactor
///

extension InvokeInteractorExtension<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  InvocationConfigurator<Input, Output,
      InitialInvocationModifier<Input, Output>> call(
    Input input,
  ) {
    return InvocationConfigurator(
      details: InvocationDetails(jobName: runtimeType.toString()),
      modifier: InitialInvocationModifier(input: input, interactor: this),
    );
  }
}
