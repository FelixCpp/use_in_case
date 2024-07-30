import 'package:use_in_case/src/interactor.dart';

extension Invoke<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  Future<void> runUnsafe(Input input) => execute(input);
  Future<void> run(Input input) async {
    try {
      await execute(input);
    } catch (_) {}
  }

  Future<Output> getOrThrow(Input input) {
    return execute(input);
  }

  Future<Output?> getOrNull(Input input) async {
    try {
      return await execute(input);
    } catch (_) {
      return null;
    }
  }

  Future<Output> getOrElse(
    Input input,
    Future<Output> Function(Exception) fallback,
  ) {
    return execute(input).onError((Exception error, _) {
      return fallback(error);
    });
  }
}
