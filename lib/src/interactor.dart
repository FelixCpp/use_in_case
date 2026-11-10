import 'dart:async';

/// Opaque marker used to share the interactor interface for no-input use cases.
final class NoInput {
  const NoInput._();

  static const instance = NoInput._();
}

/// Defines the common execution contract for all interactors.
///
/// Interactor types are interfaces: implement them rather than extending.
abstract interface class InteractorContract<Input, Output> {
  FutureOr<Output> execute(Input input);
}

extension InvokeContractExt<Input, Output>
    on InteractorContract<Input, Output> {
  FutureOr<Output> invoke(Input input) => execute(input);
}

/// Defines an interactor that receives an input.
abstract interface class ParameterizedResultInteractor<Input, Output>
    extends InteractorContract<Input, Output> {}

/// Defines an interactor that receives input and does not return a value.
typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;

/// Defines an interactor that takes no input and returns an output.
abstract interface class ResultInteractor<Output>
    extends InteractorContract<NoInput, Output> {}

/// Defines an interactor that takes no input and returns no value.
typedef Interactor = ResultInteractor<void>;

/// Adapts a function into a parameterized interactor.
final class InlinedParameterizedResultInteractor<Input, Output>
    implements ParameterizedResultInteractor<Input, Output> {
  final FutureOr<Output> Function(Input input) _execute;
  InlinedParameterizedResultInteractor(this._execute);

  @override
  FutureOr<Output> execute(Input input) => _execute(input);
}
