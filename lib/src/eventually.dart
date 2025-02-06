import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

/// This extension provides a method to execute a callback after the interactor
/// has finished.
///
/// Provided methods:
///   - [eventually]
extension EventuallyExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// This method hangs itself behind the interactor and calls
  /// the given [callback] when the interactor finishes.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .eventually(() => print('Interactor finished'))
  ///   .run(input);
  /// ```
  ///
  /// Note that the outcome of the interactor is not a creteria
  /// for the callback to be called. If you want to execute code
  /// when the interactor finishes successfully, you can use the
  /// [after] method.
  ///
  /// see [after]
  ParameterizedResultInteractor<Input, Output> eventually(
      FutureOr<void> Function() callback) {
    return InlinedParameterizedResultInteractor((input) {
      return Future(() => getOrThrow(input)).whenComplete(callback);
    });
  }
}
