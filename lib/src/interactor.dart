abstract interface class ParameterizedResultInteractor<Input, Output> {
  Future<Output> execute(Input input);
}

final class InlinedParameterizedResultInteractor<Input, Output>
    implements ParameterizedResultInteractor<Input, Output> {
  final Future<Output> Function(Input) _execute;

  InlinedParameterizedResultInteractor(this._execute);

  @override
  Future<Output> execute(Input input) {
    return _execute(input);
  }
}
