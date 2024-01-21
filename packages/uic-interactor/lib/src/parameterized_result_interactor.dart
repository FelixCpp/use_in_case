abstract interface class ParameterizedResultInteractor<Input, Output> {
  Future<Output> execute(Input input);
}
