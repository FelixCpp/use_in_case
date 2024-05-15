import 'package:uic_interactor/src/event.dart';
import 'package:uic_interactor/src/invocator.dart';
import 'package:uic_interactor/src/modifier.dart';

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

extension InvocationWithBusyStateReceiver<Parameter, Result>
    on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> receiveBusyState(void Function(bool) onChange) {
    return modifier((modifier) => BusyStateModifier(modifier, onChange));
  }
}
