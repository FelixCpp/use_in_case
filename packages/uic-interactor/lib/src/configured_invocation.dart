import 'dart:async';

import 'package:uic_interactor/src/util/invocation_details.dart';
import 'package:uic_interactor/src/util/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class ConfiguredInvocation<Input, Output> {
  final InvocationDetails details;
  final void Function(InvocationEvent<Input, Output>) onEvent;
  final InvocationModifier<Input, Output> modifier;

  const ConfiguredInvocation({
    required this.modifier,
    required this.details,
    required this.onEvent,
  });

  void run() {
    final controller = StreamController<InvocationEvent<Input, Output>>();
    final eventHandler = modifier.buildEventHandler(
      (event, _) => onEvent(event),
    );

    StreamSubscription? subscription;
    subscription = controller.stream.listen(
      (event) async {
        eventHandler(event, details);

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

    controller.addStream(modifier.buildStream());
  }
}
