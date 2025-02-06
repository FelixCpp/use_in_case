import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension InvokeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be propagated.
  Future<void> runUnsafe(Input input) async {
    await getOrThrow(input);
  }

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be caught and ignored.
  Future<void> run(Input input) async {
    try {
      await getOrThrow(input);
    } catch (_) {}
  }

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, it will be caught and null will be returned.
  Future<Output?> getOrNull(Input input) async {
    try {
      return await getOrThrow(input);
    } catch (_) {
      return null;
    }
  }

  /// Executes the interactor and returns the output.
  /// If an exception is thrown, the [fallback] function will be called and its result will be returned.
  Future<Output> getOrElse(
    Input input,
    FutureOr<Output> Function(Exception) fallback,
  ) async {
    try {
      return await getOrThrow(input);
    } on Exception catch (exception) {
      return await fallback(exception);
    }
  }
}
