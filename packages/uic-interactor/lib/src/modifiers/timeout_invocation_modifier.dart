import 'dart:async';

import 'package:uic_interactor/src/invocation_details.dart';
import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class TimeoutInvocationModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final Duration _timeoutDuration;
  final InvocationModifier<Input, Output> _modifier;
  final String? _message;

  const TimeoutInvocationModifier({
    required Duration timeoutDuration,
    required InvocationModifier<Input, Output> modifier,
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
