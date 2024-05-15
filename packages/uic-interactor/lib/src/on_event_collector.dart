import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/invocator.dart';
import 'package:use_in_case/src/modifier.dart';

final class OnEventCollectorModifier<Parameter, Result> extends ChainedModifier<Parameter, Result> {
  final void Function(Event<Parameter, Result> event) onEvent;
  const OnEventCollectorModifier(super._modifier, this.onEvent);

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return super.buildEventHandler().after((_, event) => onEvent(event));
  }
}

extension InvocationWithEventCollector<Parameter, Result> on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> onEvent(void Function(Event<Parameter, Result>) callback) {
    return modifier((modifier) {
      return OnEventCollectorModifier<Parameter, Result>(modifier, (event) => callback(event));
    });
  }

  Invocator<Parameter, Result> onStart(void Function(Parameter) callback) {
    return onEvent((event) => event.whenOrNull(onStart: callback));
  }

  Invocator<Parameter, Result> onResult(void Function(Result) callback) {
    return onEvent((event) => event.whenOrNull(onResult: callback));
  }

  Invocator<Parameter, Result> onException(void Function(Exception) callback) {
    return onEvent((event) => event.whenOrNull(onException: callback));
  }
}
