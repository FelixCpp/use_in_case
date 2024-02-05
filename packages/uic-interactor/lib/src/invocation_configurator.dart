import 'dart:async';

import 'package:uic_interactor/src/configured_invocation.dart';
import 'package:uic_interactor/src/modifiers/initial_invocation_modifier.dart';
import 'package:uic_interactor/uic_interactor.dart';

class InvocationConfigurator<Input, Output> {
  final InvocationDetails _details;
  final InvocationModifier<Input, Output> _modifier;

  const InvocationConfigurator._internalBuild({
    required InvocationDetails details,
    required InvocationModifier<Input, Output> modifier,
  })  : _details = details,
        _modifier = modifier;

  Future<Output> get() {
    final completer = Completer<Output>();

    configure(
      run: true,
      onSuccess: (output) => completer.complete(output),
      onFailure: (exception) => completer.completeError(exception),
    );

    return completer.future;
  }

  Future<void> ignore() => get().then((_) {});

  Future<Output?> getOrNull() {
    return get()
        .then((value) => Future<Output?>.value(value))
        .catchError((_) => null);
  }

  Future<Output> getOrElse({required Output fallback}) {
    return get().catchError((_) => fallback);
  }

  ConfiguredInvocation<Input, Output> configure({
    required bool run,
    void Function(Input)? onStart,
    void Function(Output)? onSuccess,
    void Function(Exception)? onFailure,
  }) {
    final invocation = ConfiguredInvocation(
      modifier: _modifier,
      details: _details,
      onEvent: (event) => event.whenOrNull(
        onStart: onStart,
        onSuccess: onSuccess,
        onFailure: onFailure,
      ),
    );

    if (run) {
      invocation.run();
    }

    return invocation;
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
    final modifier = modifierBuilders.fold<InvocationModifier<Input, Output>>(
      InitialInvocationModifier(
        input: input,
        interactor: this,
      ),
      (current, builder) => builder.build(current),
    );

    return InvocationConfigurator._internalBuild(
      details: InvocationDetails(jobName: runtimeType.toString()),
      modifier: modifier,
    );
  }
}

extension InvocationModifierApplier<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> modifier(
    InvocationModifierBuilder<Input, Output> builder,
  ) {
    return InvocationConfigurator._internalBuild(
      details: _details,
      modifier: builder.build(_modifier),
    );
  }
}
