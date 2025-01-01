import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension Invoke<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be propagated.
  Future<void> runUnsafe(Input input) => Future(() => execute(input));

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be caught and ignored.
  Future<void> run(Input input) async {
    try {
      await execute(input);
    } catch (_) {}
  }

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be propagated.
  Future<Output> getOrThrow(Input input) => Future(() => execute(input));

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be caught and null will be returned.
  Future<Output?> getOrNull(Input input) {
    return getOrThrow(input)
        .then((value) => Future<Output?>.value(value))
        .onError((_, __) => null);
  }

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, the [fallback] function will be called and its result will be returned.
  Future<Output> getOrElse(
    Input input,
    FutureOr<Output> Function(Exception) fallback,
  ) {
    return getOrThrow(input).onError(
      (error, _) => fallback(error as Exception),
      test: (error) => error is Exception,
    );
  }
}
