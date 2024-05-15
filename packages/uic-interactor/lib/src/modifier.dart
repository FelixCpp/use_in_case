import 'package:use_in_case/src/event.dart';

///
/// A modifier that can be applied in order to insert
/// custom behavior into the invocation flow of an
/// interactor.
///
abstract interface class Modifier<Parameter, Result> {
  Stream<Event<Parameter, Result>> buildStream();
  EventHandler<Parameter, Result> buildEventHandler();
}

///
/// Handy type definition for a modifier builder.
///
typedef ModifierBuilder<Parameter, Result> = Modifier<Parameter, Result> Function(
  Modifier<Parameter, Result>,
);

///
/// Forwarding implementation of a [Modifier] that can be extended
/// to implement the 'default' behavior of a forwarding modifier.
///
class ChainedModifier<Parameter, Result> implements Modifier<Parameter, Result> {
  final Modifier<Parameter, Result> _modifier;
  const ChainedModifier(this._modifier);

  @override
  Stream<Event<Parameter, Result>> buildStream() {
    return _modifier.buildStream();
  }

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return _modifier.buildEventHandler();
  }
}
