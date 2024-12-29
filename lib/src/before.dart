import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension Before<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> before(
    FutureOr<void> Function(Input) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      await callback(input);
      return execute(input);
    });
  }
}
