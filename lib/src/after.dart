import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// This extension provides a method to receive the result of an interactor.
///
/// Provided methods:
///   - [after]
extension AfterExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// This method hangs itself behind the interactor and calls
  /// the given [callback] when the interactor finishes
  /// successfully.
  ///
  /// The [callback] will be called with the output of the
  /// previous interactor.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .after((output) => print('Interactor finished with: $output'))
  ///   .run(input);
  /// ```
  ///
  /// To ensure that the [callback] is being called when the
  /// interactor finished reguardless of whether the invocation
  /// has been successful or not, you can chain the [eventually]
  /// method.
  ///
  /// For mapping the output of the interactor, you can use the
  /// [map] method.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .after((output) => print('Interactor finished with: $output'))
  ///   .map((output) => output * 3.141592)
  ///   .after((output) => print('Mapped output: $output'))
  ///   .run(input);
  /// ```
  ///
  /// see [eventually]
  ParameterizedResultInteractor<Input, Output> after(
    FutureOr<void> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final output = await getOrThrow(input);
      await callback(output);
      return output;
    });
  }
}
