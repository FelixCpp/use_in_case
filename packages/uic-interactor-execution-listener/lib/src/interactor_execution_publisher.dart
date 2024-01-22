import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_listener.dart';

class InteractorExecutionPublisherModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final InvocationModifier<Input, Output> _modifier;
  final void Function(InvocationEvent<Input, Output>) _onEvent;

  const InteractorExecutionPublisherModifier({
    required void Function(InvocationEvent<Input, Output>) onEvent,
    required InvocationModifier<Input, Output> modifier,
  })  : _onEvent = onEvent,
        _modifier = modifier;

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return _modifier.buildStream();
  }

  @override
  void notify(
    InvocationDetails details,
    InvocationEvent<Input, Output> event,
    void Function(InvocationEvent<Input, Output>) callback,
  ) {
    return _modifier.notify(details, event, (event) {
      event.map(
        onStart: (event) {
          _onEvent(event);
          callback(event);
        },
        onSuccess: (event) {
          callback(event);
          _onEvent(event);
        },
        onFailure: (event) {
          callback(event);
          _onEvent(event);
        },
      );
    });
  }
}

extension InteractorExecutionPublisherModifierExtension<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> publishTo(
    InteractorExecutionListener listener,
  ) {
    return InvocationConfigurator(
      details: details,
      modifier: InteractorExecutionPublisherModifier(
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
      modifier: InteractorExecutionPublisherModifier(
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
