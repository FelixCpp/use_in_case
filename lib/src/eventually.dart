import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension EventuallyExt<Input, Output> on InteractorContract<Input, Output> {
  /// Invokes [callback] when execution completes, whether it succeeds or fails.
  ParameterizedResultInteractor<Input, Output> eventually(
    FutureOr<void> Function() callback,
  ) {
    return InlinedParameterizedResultInteractor(
      (input) => Future(() => invoke(input)).whenComplete(callback),
    );
  }
}
