import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

mixin _ProgressEmitter<Progress> {
  late FutureOr<void> Function(Progress progress) _callback;

  Future<void> emitProgress(Progress progress) =>
      Future(() => _callback(progress));
}

/// A progress-emitting interactor that receives an input.
///
/// Must be extended (not implemented) to inherit [emitProgress]. It is not an
/// interactor itself: call [ReceiveProgressExtension.receiveProgress] to obtain
/// one that supports the usual modifier chain.
abstract base class ParameterizedResultProgressInteractor<Input, Output,
    Progress> with _ProgressEmitter<Progress> {
  FutureOr<Output> execute(Input input);
}

typedef ParameterizedProgressInteractor<Input, Progress>
    = ParameterizedResultProgressInteractor<Input, void, Progress>;

/// A progress-emitting interactor that takes no input.
///
/// Must be extended (not implemented) to inherit [emitProgress]. It is not an
/// interactor itself: call [ResultReceiveProgressExtension.receiveProgress] to
/// obtain one that supports the usual modifier chain.
abstract base class ResultProgressInteractor<Output, Progress>
    with _ProgressEmitter<Progress> {
  FutureOr<Output> execute(NoInput input);
}

typedef ProgressInteractor<Progress> = ResultProgressInteractor<void, Progress>;

extension ReceiveProgressExtension<Input, Output, Progress>
    on ParameterizedResultProgressInteractor<Input, Output, Progress> {
  /// Registers the callback used to receive progress events.
  ParameterizedResultInteractor<Input, Output> receiveProgress(
    FutureOr<void> Function(Progress) callback,
  ) {
    _callback = callback;
    return InlinedParameterizedResultInteractor(execute);
  }
}

extension ResultReceiveProgressExtension<Output, Progress>
    on ResultProgressInteractor<Output, Progress> {
  /// Registers the callback used to receive progress events.
  ParameterizedResultInteractor<NoInput, Output> receiveProgress(
    FutureOr<void> Function(Progress) callback,
  ) {
    _callback = callback;
    return InlinedParameterizedResultInteractor(
      (_) => execute(NoInput.instance),
    );
  }
}
