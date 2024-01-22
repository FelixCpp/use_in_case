import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_listener.dart';

class InteractorExecutionPublisherModifier<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    implements InvocationModifier<Input, Output> {
  final Modifier _modifier;
  final InteractorExecutionListener _listener;

  const InteractorExecutionPublisherModifier({
    required InteractorExecutionListener listener,
    required Modifier modifier,
  })  : _listener = listener,
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
          _listener.addLoader();
          callback(event);
        },
        onSuccess: (event) {
          _listener.removeLoader();
          callback(event);
        },
        onFailure: (event) {
          _listener.removeLoader();
          callback(event);
        },
      );
    });
  }
}

extension InteractorExecutionPublisherModifierExtension<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    on InvocationConfigurator<Input, Output, Modifier> {
  InvocationConfigurator<Input, Output,
          InteractorExecutionPublisherModifier<Input, Output, Modifier>>
      publishTo(InteractorExecutionListener listener) {
    return InvocationConfigurator(
      details: details,
      modifier: InteractorExecutionPublisherModifier(
        listener: listener,
        modifier: modifier,
      ),
    );
  }
}
