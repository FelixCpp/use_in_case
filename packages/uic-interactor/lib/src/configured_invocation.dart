import 'dart:async';

import 'package:uic_interactor/src/invocation_details.dart';
import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class ConfiguredInvocation<Input, Output> {
  final InvocationDetails _details;
  final void Function(InvocationEvent<Input, Output>) _onEvent;
  final InvocationModifier<Input, Output> _modifier;

  const ConfiguredInvocation({
    required InvocationDetails details,
    required void Function(InvocationEvent<Input, Output>) onEvent,
    required InvocationModifier<Input, Output> modifier,
  })  : _details = details,
        _onEvent = onEvent,
        _modifier = modifier;

  void run() {
    final controller = StreamController<InvocationEvent<Input, Output>>();
    final eventHandler = _modifier.buildEventHandler(
      (event, _) => _onEvent(event),
    );

    StreamSubscription? subscription;
    subscription = controller.stream.listen(
      (event) async {
        eventHandler.call(event, _details);

        if (event.maybeMap(
            onSuccess: (_) => true,
            onFailure: (_) => true,
            orElse: () => false)) {
          await subscription?.cancel();
          await controller.close();
        }
      },
      cancelOnError: true,
    );

    controller.addStream(_modifier.buildStream());
  }
}
