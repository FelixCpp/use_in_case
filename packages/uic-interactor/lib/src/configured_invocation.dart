import 'package:uic_interactor/src/invocation_details.dart';
import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class ConfiguredInvocation<Input, Output,
    Modifier extends InvocationModifier<Input, Output>> {
  final InvocationDetails _details;
  final void Function(InvocationEvent<Input, Output>) _onEvent;
  final Modifier _modifier;

  const ConfiguredInvocation({
    required InvocationDetails details,
    required void Function(InvocationEvent<Input, Output>) onEvent,
    required Modifier modifier,
  })  : _details = details,
        _onEvent = onEvent,
        _modifier = modifier;

  void run() {
    final stream = _modifier.buildStream();

    stream.listen(
      (event) => _modifier.notify(_details, event, _onEvent),
      cancelOnError: true,
    );
  }
}
