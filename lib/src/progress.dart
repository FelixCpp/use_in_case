import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

mixin _ProgressEmitter<Progress> {
  late final FutureOr<void> Function(Progress progress) _callback;

  Future<void> emitProgress(Progress progress) =>
      Future(() => _callback(progress));
}

/// A progress-emitting interactor that receives an input.
abstract base class ParameterizedResultProgressInteractor<Input, Output,
        Progress> extends ParameterizedResultInteractor<Input, Output>
    with _ProgressEmitter<Progress> {
  FutureOr<Output> getOrThrow(Input input);

  @override
  FutureOr<Output> invoke(Input input) => getOrThrow(input);
}

typedef ParameterizedProgressInteractor<Input, Progress>
    = ParameterizedResultProgressInteractor<Input, void, Progress>;

/// A progress-emitting interactor that takes no input.
abstract base class ResultProgressInteractor<Output, Progress>
    extends ResultInteractor<Output> with _ProgressEmitter<Progress> {
  @override
  FutureOr<Output> getOrThrow();
}

typedef ProgressInteractor<Progress> = ResultProgressInteractor<void, Progress>;

extension ReceiveProgressExtension<Input, Output, Progress>
    on ParameterizedResultProgressInteractor<Input, Output, Progress> {
  /// Registers the callback used to receive progress events.
  ParameterizedResultInteractor<Input, Output> receiveProgress(
    FutureOr<void> Function(Progress) callback,
  ) {
    _callback = callback;
    return InlinedParameterizedResultInteractor(invoke);
  }
}

extension ResultReceiveProgressExtension<Output, Progress>
    on ResultProgressInteractor<Output, Progress> {
  /// Registers the callback used to receive progress events.
  ParameterizedResultInteractor<NoInput, Output> receiveProgress(
    FutureOr<void> Function(Progress) callback,
  ) {
    _callback = callback;
    return InlinedParameterizedResultInteractor((_) => getOrThrow());
  }
}
