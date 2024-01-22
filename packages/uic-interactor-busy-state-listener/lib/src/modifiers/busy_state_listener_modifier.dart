import 'package:uic_interactor/uic_interactor.dart';

class BusyStateListenerModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final InvocationModifier<Input, Output> _modifier;
  final void Function(InvocationEvent<Input, Output>) _onEvent;

  const BusyStateListenerModifier({
    required void Function(InvocationEvent<Input, Output>) onEvent,
    required InvocationModifier<Input, Output> modifier,
  })  : _onEvent = onEvent,
        _modifier = modifier;

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return _modifier.buildStream();
  }

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return _modifier.buildEventHandler((event, details) {
      event.map(
        onStart: (event) {
          _onEvent(event);
          callback(event, details);
        },
        onSuccess: (event) {
          callback(event, details);
          _onEvent(event);
        },
        onFailure: (event) {
          callback(event, details);
          _onEvent(event);
        },
      );
    });
  }
}
