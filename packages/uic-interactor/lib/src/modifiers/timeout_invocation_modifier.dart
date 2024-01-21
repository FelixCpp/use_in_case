import 'dart:async';

import 'package:uic_interactor/src/invocation_details.dart';
import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class TimeoutInvocationModifier<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    implements InvocationModifier<Input, Output> {
  final Duration _timeoutDuration;
  final Modifier _modifier;
  final String? _message;

  const TimeoutInvocationModifier({
    required Duration timeoutDuration,
    required Modifier modifier,
    String? message,
  })  : _timeoutDuration = timeoutDuration,
        _modifier = modifier,
        _message = message;

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return _modifier.buildStream().timeout(_timeoutDuration, onTimeout: (sink) {
      sink.add(
        InvocationEvent.onFailure(
          TimeoutException(_message, _timeoutDuration),
        ),
      );
    });
  }

  @override
  void notify(
    InvocationDetails details,
    InvocationEvent<Input, Output> event,
    void Function(InvocationEvent<Input, Output>) callback,
  ) {
    return _modifier.notify(details, event, callback);
  }
}
