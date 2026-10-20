import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension TimeoutExt<Input, Output> on InteractorContract<Input, Output> {
  /// Fails with [TimeoutException] if the invocation exceeds [duration].
  ParameterizedResultInteractor<Input, Output> timeout(
    Duration duration, {
    FutureOr<String?> Function()? lazyErrorMessage,
  }) {
    return InlinedParameterizedResultInteractor(
      (input) => Future<Output>(() => invoke(input)).timeout(
        duration,
        onTimeout: () async {
          final message = await lazyErrorMessage?.call();
          throw TimeoutException(message, duration);
        },
      ),
    );
  }
}
