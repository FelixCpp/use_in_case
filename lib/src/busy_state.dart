import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

typedef IsBusy = bool;

extension BusyState<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> watchBusyState(
    Future<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      return callback(true)
          .then((_) => execute(input))
          .whenComplete(() => callback(false));
    });
  }

  ParameterizedResultInteractor<Input, Output> debounceBusyState(
    Future<void> Function(IsBusy) callback, {
    required Duration duration,
  }) {
    return InlinedParameterizedResultInteractor<Input, Output>((input) async {
      var isRunning = false;
      var emitted = false;

      Future.delayed(duration, () {
        if (isRunning) {
          callback(emitted = true);
        }
      });

      isRunning = true;
      return execute(input).whenComplete(() {
        isRunning = false;
        if (emitted) {
          callback(false);
        }
      });
    });
  }
}
