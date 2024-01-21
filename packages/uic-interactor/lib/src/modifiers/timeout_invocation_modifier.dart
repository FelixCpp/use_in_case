import 'dart:async';

import 'package:uic_interactor/src/invocation_event.dart';
import 'package:uic_interactor/src/modifiers/invocation_modifier.dart';

class TimeoutInvocationModifier<Modifier extends InvocationModifier>
    implements InvocationModifier {
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
  Stream<InvocationEvent> buildStream() {
    return _modifier.buildStream().timeout(_timeoutDuration, onTimeout: (sink) {
      sink.add(
        InvocationEvent.onFailure(
          TimeoutException(_message, _timeoutDuration),
        ),
      );
    });
  }
}
