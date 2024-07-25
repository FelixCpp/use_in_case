import 'package:use_in_case/src/interactor.dart';

extension BusyState<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> onBusyStateChange(
    Future<void> Function(bool) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) {
      callback(true);
      return execute(input).whenComplete(() {
        callback(false);
      });
    });
  }
}
