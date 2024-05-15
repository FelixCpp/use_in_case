import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/invocator.dart';
import 'package:use_in_case/src/modifiers/chained_modifier.dart';

///
/// Register a generic callback that gets called when
/// an event is being emitted by the stream.
///
final class OnEventModifier<Parameter, Result>
    extends ChainedModifier<Parameter, Result> {
  final void Function(Event<Parameter, Result> event) onEvent;
  const OnEventModifier(super._modifier, this.onEvent);

  ///
  /// Extends the previous event handler by appending
  /// the callback after the original handler.
  ///
  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return super.buildEventHandler().after((_, event) => onEvent(event));
  }
}

///
/// A couple of extension methods to make the syntax prettier.
///
/// The following code will be available:
///
/// final _ = await interactor(...)
///   .onStart(printInfo)
///   .onResult(printSuccess)
///   .onException(printError)
///   .onEvent(printDebug);
///
extension InvocationWithEvent<Parameter, Result>
    on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> onEvent(
      void Function(Event<Parameter, Result>) callback) {
    return modifier((modifier) {
      return OnEventModifier<Parameter, Result>(
          modifier, (event) => callback(event));
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
