import 'dart:async';

import 'package:dartz/dartz.dart';

/// Defines the interface for an interactor.
/// All interactors must implement this interface in order to fit into the use case architecture.
abstract interface class ParameterizedResultInteractor<Input, Output> {
  FutureOr<Output> execute(Input input);
}

typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;
typedef ResultInteractor<Output> = ParameterizedResultInteractor<Unit, Output>;
typedef Interactor = ParameterizedResultInteractor<Unit, void>;

final class InlinedParameterizedResultInteractor<Input, Output>
    implements ParameterizedResultInteractor<Input, Output> {
  final FutureOr<Output> Function(Input input) _execute;

  const InlinedParameterizedResultInteractor(this._execute);

  @override
  FutureOr<Output> execute(Input input) => _execute(input);
}
