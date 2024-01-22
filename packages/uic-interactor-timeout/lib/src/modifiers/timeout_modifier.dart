import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';

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
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return (event, details) => callback(event, details);
  }
}
