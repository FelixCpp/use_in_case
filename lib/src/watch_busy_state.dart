import 'package:use_in_case/src/interactor.dart';

typedef IsBusy = bool;

extension WatchBusyState<Input, Output>
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
}
