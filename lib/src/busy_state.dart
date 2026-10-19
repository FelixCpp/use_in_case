import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

typedef IsBusy = bool;

extension BusyStateExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Calls [callback] with `true` before and `false` after execution.
  ParameterizedResultInteractor<Input, Output> busyStateChange(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        await callback(true);
        return await invoke(input);
      } finally {
        await callback(false);
      }
    });
  }

  /// Emits busy-state changes to [controller].
  ParameterizedResultInteractor<Input, Output> emitBusyStateChange(
    StreamController<IsBusy> controller,
  ) =>
      busyStateChange(controller.add);

  /// Deprecated alias for [busyStateChange].
  @Deprecated('Use busyStateChange instead')
  ParameterizedResultInteractor<Input, Output> watchBusyState(
    FutureOr<void> Function(IsBusy) callback,
  ) =>
      busyStateChange(callback);
}
