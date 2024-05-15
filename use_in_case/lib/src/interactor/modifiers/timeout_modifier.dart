import 'dart:async';

import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/interactor/modifiers/chained_modifier.dart';
import 'package:use_in_case/src/invocator.dart';

///
/// This modifier applies a timeout on the stream that emits invocation events.
/// This is useful for cancelling an invocation after a given amount of time without having
/// to manage some kind of cancellation token.
///
class TimeoutModifier<Parameter, Result>
    extends ChainedModifier<Parameter, Result> {
  final Duration _timeout;
  final String? _errorMessage;
  const TimeoutModifier(super.modifier, this._timeout, this._errorMessage);

  @override
  Stream<Event<Parameter, Result>> buildStream() {
    return super.buildStream().timeout(_timeout, onTimeout: (sink) {
      sink.add(Event.onException(TimeoutException(_errorMessage, _timeout)));
    });
  }
}

///
/// Handy extension that applies the timeout modifier
///
extension InvocationWithTimeout<Parameter, Result>
    on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> timeout(Duration timeout,
      [String? errorMessage]) {
    return modifier(
        (modifier) => TimeoutModifier(modifier, timeout, errorMessage));
  }
}
