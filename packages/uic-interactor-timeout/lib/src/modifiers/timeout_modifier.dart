import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';

class TimeoutInvocationModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final Duration _timeoutDuration;
  final String? _message;

  const TimeoutInvocationModifier({
    required Duration timeoutDuration,
    required super.modifier,
    String? message,
  })  : _timeoutDuration = timeoutDuration,
        _message = message;

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream().timeout(_timeoutDuration, onTimeout: (sink) {
      sink.add(
        InvocationEvent.onFailure(
          TimeoutException(_message, _timeoutDuration),
        ),
      );
    });
  }
}
