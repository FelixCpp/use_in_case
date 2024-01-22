import 'package:uic_interactor/uic_interactor.dart';

class ExecutionListenerModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final InvocationModifier<Input, Output> _modifier;
  final void Function(InvocationEvent<Input, Output>) _onEvent;

  const ExecutionListenerModifier({
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
