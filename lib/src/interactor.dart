import 'package:dartz/dartz.dart';

abstract interface class ParameterizedResultInteractor<Input, Output> {
  Future<Output> execute(Input input);
}

typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;
typedef ResultInteractor<Output> = ParameterizedResultInteractor<Unit, Output>;
typedef Interactor = ParameterizedResultInteractor<Unit, void>;

final class InlinedParameterizedResultInteractor<Input, Output>
    implements ParameterizedResultInteractor<Input, Output> {
  final Future<Output> Function(Input input) _execute;

  const InlinedParameterizedResultInteractor(this._execute);

  @override
  Future<Output> execute(Input input) => _execute(input);
}
