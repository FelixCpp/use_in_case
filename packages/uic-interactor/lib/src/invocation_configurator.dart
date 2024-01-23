import 'dart:async';

import 'package:uic_interactor/src/configured_invocation.dart';
import 'package:uic_interactor/src/modifiers/initial_invocation_modifier.dart';
import 'package:uic_interactor/uic_interactor.dart';

class InvocationConfigurator<Input, Output> {
  final InvocationDetails _details;
  final InvocationModifier<Input, Output> _modifier;

  const InvocationConfigurator({
    required InvocationDetails details,
    required InvocationModifier<Input, Output> modifier,
  })  : _details = details,
        _modifier = modifier;

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
        .catchError((_) => null);
  }

  Future<Output> getOrElse({required Output fallback}) {
    return get().catchError((_) => fallback);
  }

  ConfiguredInvocation<Input, Output> configure(
    void Function(InvocationEvent<Input, Output>) onEvent,
  ) {
    return ConfiguredInvocation(
      modifier: _modifier,
      details: _details,
      onEvent: onEvent,
    );
  }
}

///
/// Invocable Interactor
///

extension InvokeInteractorExtension<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  InvocationConfigurator<Input, Output> call(
    Input input,
  ) {
    return InvocationConfigurator(
      details: InvocationDetails(jobName: runtimeType.toString()),
      modifier: InitialInvocationModifier(input: input, interactor: this),
    );
  }
}

extension InvocationModifierApplier<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> modifier(
    InvocationModifier<Input, Output> Function(
      InvocationModifier<Input, Output>,
    ) builder,
  ) {
    return InvocationConfigurator(
      details: _details,
      modifier: builder(_modifier),
    );
  }
}
