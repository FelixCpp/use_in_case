import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension AfterExt<Input, Output> on InteractorContract<Input, Output> {
  /// Invokes [callback] with the output after a successful invocation.
  ParameterizedResultInteractor<Input, Output> after(
    FutureOr<void> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final output = await invoke(input);
      await callback(output);
      return output;
    });
  }
}
