import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension Invoke<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  FutureOr<void> runUnsafe(Input input) => execute(input);
  FutureOr<void> run(Input input) async {
    try {
      await execute(input);
    } catch (_) {}
  }

  FutureOr<Output> getOrThrow(Input input) {
    return execute(input);
  }

  FutureOr<Output?> getOrNull(Input input) async {
    try {
      return await execute(input);
    } catch (_) {
      return null;
    }
  }

  Future<Output> getOrElse(
    Input input,
    FutureOr<Output> Function(Exception) fallback,
  ) async {
    try {
      return await execute(input);
    } on Exception catch (exception) {
      return await fallback(exception);
    }
  }
}
