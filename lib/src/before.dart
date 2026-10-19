import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension BeforeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Invokes [callback] with the input before executing the interactor.
  ParameterizedResultInteractor<Input, Output> before(
    FutureOr<void> Function(Input) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      await callback(input);
      return invoke(input);
    });
  }
}
