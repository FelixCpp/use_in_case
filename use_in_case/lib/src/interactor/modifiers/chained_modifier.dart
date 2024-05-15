import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/interactor/modifiers/modifier.dart';

///
/// Forwarding implementation of a [Modifier] that can be extended
/// to implement the 'default' behavior of a forwarding modifier.
///
class ChainedModifier<Parameter, Result>
    implements Modifier<Parameter, Result> {
  final Modifier<Parameter, Result> _modifier;
  const ChainedModifier(this._modifier);

  ///
  /// Simply forward the stream
  ///
  @override
  Stream<Event<Parameter, Result>> buildStream() {
    return _modifier.buildStream();
  }

  ///
  /// Simply forward the event handler
  ///
  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return _modifier.buildEventHandler();
  }
}
