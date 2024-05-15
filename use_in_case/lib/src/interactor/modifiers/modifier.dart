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
typedef ModifierBuilder<Parameter, Result> = Modifier<Parameter, Result>
    Function(
  Modifier<Parameter, Result>,
);
