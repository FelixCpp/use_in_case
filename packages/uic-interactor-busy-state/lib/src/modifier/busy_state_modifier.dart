import 'package:uic_interactor/uic_interactor.dart';

class BusyStateListenerModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final void Function(InvocationEvent<Input, Output>) onEvent;

  const BusyStateListenerModifier({
    required super.modifier,
    required this.onEvent,
  });

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      event.map(
        onStart: (event) {
          onEvent(event);
          callback(event, details);
        },
        onSuccess: (event) {
          callback(event, details);
          onEvent(event);
        },
        onFailure: (event) {
          callback(event, details);
          onEvent(event);
        },
      );
    });
  }
}
