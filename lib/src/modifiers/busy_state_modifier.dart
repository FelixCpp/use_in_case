import '../event.dart';
import '../invocator.dart';
import 'chained_modifier.dart';

///
/// Implementation of a invocation modifier.
/// This modifier allows to get notified when the
/// interactor changes it's busy-state. As soon as
/// the invocation starts, it will publish *true*. When
/// the invocation is done *false* will be published.
///
final class BusyStateModifier<Parameter, Result>
    extends ChainedModifier<Parameter, Result> {
  final void Function(bool) _onStateChange;

  const BusyStateModifier(super._modifier, this._onStateChange);

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return super.buildEventHandler().wrap((details, event) {
      event.when(
        onStart: (_) => _onStateChange(true),
        onResult: (_) => _onStateChange(false),
        onException: (_) => _onStateChange(false),
      );
    });
  }
}

///
/// Handy extension to add the busy-state modifier to an invocation.
///
extension InvocationWithBusyStateReceiver<Parameter, Result>
    on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> receiveBusyState(void Function(bool) onChange) {
    return modifier((modifier) => BusyStateModifier(modifier, onChange));
  }
}
