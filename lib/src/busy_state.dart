import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

typedef IsBusy = bool;

extension BusyState<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> watchBusyState(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        await callback(true);
        return await execute(input);
      } finally {
        await callback(false);
      }
    });
  }
}
