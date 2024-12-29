import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension After<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> after(
    FutureOr<void> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final output = await execute(input);
      await callback(output);
      return output;
    });
  }
}
