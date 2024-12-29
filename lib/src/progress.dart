import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/src/interactor.dart';

abstract base class ParameterizedResultProgressInteractor<Input, Output,
    Progress> {
  late final FutureOr<void> Function(Progress progress) callback;
  FutureOr<Output> execute(Input input);

  FutureOr<void> emitProgress(Progress progress) {
    return callback(progress);
  }
}

typedef ParameterizedProgressInteractor<Input, Progress>
    = ParameterizedResultProgressInteractor<Input, void, Progress>;
typedef ResultProgressInteractor<Output, Progress>
    = ParameterizedResultProgressInteractor<Unit, Output, Progress>;
typedef ProgressInteractor<Progress>
    = ParameterizedResultProgressInteractor<Unit, void, Progress>;

extension ReceiveProgressExtension<Input, Output, Progress>
    on ParameterizedResultProgressInteractor<Input, Output, Progress> {
  ParameterizedResultInteractor<Input, Output> receiveProgress(
    FutureOr<void> Function(Progress) callback,
  ) {
    this.callback = callback;

    return InlinedParameterizedResultInteractor<Input, Output>((input) {
      return execute(input);
    });
  }
}
