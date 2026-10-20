import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension type const IsBusy(bool value) implements bool {}

extension BusyStateExt<Input, Output> on InteractorContract<Input, Output> {
  /// Calls [callback] with `true` before and `false` after execution.
  ParameterizedResultInteractor<Input, Output> busyStateChange(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        await callback(IsBusy(true));
        return await invoke(input);
      } finally {
        await callback(IsBusy(false));
      }
    });
  }

  /// Emits busy-state changes to [controller].
  ParameterizedResultInteractor<Input, Output> emitBusyStateChange(
    StreamController<IsBusy> controller,
  ) {
    return busyStateChange(controller.add);
  }
}
