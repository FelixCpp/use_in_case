import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

extension InvokeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Executes the interactor and propagates any thrown object.
  Future<void> runUnsafe(Input input) async {
    await invoke(input);
  }

  /// Executes the interactor and propagates any thrown object.
  Future<Output> getOrThrow(Input input) async => await invoke(input);

  /// Executes the interactor and ignores [Exception]s. Dart [Error]s propagate.
  Future<void> run(Input input) async {
    try {
      await invoke(input);
    } on Exception {
      // Deliberately ignore exceptions, but let programming errors propagate.
    }
  }

  /// Returns `null` when the interactor throws an [Exception].
  Future<Output?> getOrNull(Input input) async {
    try {
      return await invoke(input);
    } on Exception {
      return null;
    }
  }

  /// Returns a fallback value when the interactor throws an [Exception].
  Future<Output> getOrElse(
    Input input,
    FutureOr<Output> Function(Exception) fallback,
  ) async {
    try {
      return await invoke(input);
    } on Exception catch (exception) {
      return await fallback(exception);
    }
  }
}

extension NoInputInvokeExt<Output>
    on ParameterizedResultInteractor<NoInput, Output> {
  /// Executes a no-input interactor and propagates any thrown object.
  Future<void> runUnsafe() async {
    await invoke(NoInput.instance);
  }

  /// Executes a no-input interactor and propagates any thrown object.
  Future<Output> getOrThrow() async => await invoke(NoInput.instance);

  /// Executes a no-input interactor and ignores [Exception]s.
  Future<void> run() async {
    try {
      await invoke(NoInput.instance);
    } on Exception {
      // Deliberately ignore exceptions, but let programming errors propagate.
    }
  }

  /// Returns `null` when a no-input interactor throws an [Exception].
  Future<Output?> getOrNull() async {
    try {
      return await invoke(NoInput.instance);
    } on Exception {
      return null;
    }
  }

  /// Returns a fallback value when a no-input interactor throws an [Exception].
  Future<Output> getOrElse(
    FutureOr<Output> Function(Exception) fallback,
  ) async {
    try {
      return await invoke(NoInput.instance);
    } on Exception catch (exception) {
      return await fallback(exception);
    }
  }
}
