import 'dart:async';

import 'package:uic_interactor/uic_interactor.dart';

class TimeoutInvocationModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final Duration timeoutDuration;
  final String? message;

  const TimeoutInvocationModifier({
    required super.modifier,
    required this.timeoutDuration,
    required this.message,
  });

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream().timeout(timeoutDuration, onTimeout: (sink) {
      sink.add(
        InvocationEvent.onFailure(
          TimeoutException(message, timeoutDuration),
        ),
      );
    });
  }
}
