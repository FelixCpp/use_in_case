import 'dart:async';

/// Opaque marker used to share the interactor interface for no-input use cases.
final class NoInput {
  const NoInput._();

  static const instance = NoInput._();
}

/// Defines the common execution contract for all interactors.
abstract class ParameterizedResultInteractor<Input, Output> {
  FutureOr<Output> invoke(Input input);
}

/// Defines an interactor that receives input and does not return a value.
typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;

/// Defines an interactor that takes no input and returns an output.
abstract class ResultInteractor<Output>
    extends ParameterizedResultInteractor<NoInput, Output> {
  FutureOr<Output> getOrThrow();

  @override
  FutureOr<Output> invoke(NoInput input) => getOrThrow();
}

/// Defines an interactor that takes no input and returns no value.
typedef Interactor = ResultInteractor<void>;

/// Adapts a function into a parameterized interactor.
final class InlinedParameterizedResultInteractor<Input, Output>
    extends ParameterizedResultInteractor<Input, Output> {
  final FutureOr<Output> Function(Input input) _execute;
  InlinedParameterizedResultInteractor(this._execute);

  @override
  FutureOr<Output> invoke(Input input) => _execute(input);
}
