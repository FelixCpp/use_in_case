import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

/// This extension provides a method to map the output of an interactor.
///
/// Provided methods:
///   - [map]
extension MapExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// This method maps the output of the interactor with the given [callback].
  /// Note that the return type of [callback] does not have to match the
  /// original output type of the interactor.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// final result = interactor
  ///   .map((output) => output + 0.141592)
  ///   .getOrThrow(3);
  ///
  /// print(result); // 3.141592
  /// ```
  ///
  /// When you don't need to convert the output of the interactor
  /// but execute a block of code after the interactor finishes,
  /// you can use the [after] or [eventually] method.
  ///
  /// see [after], [eventually]
  ParameterizedResultInteractor<Input, NewOutput> map<NewOutput>(
    FutureOr<NewOutput> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor<Input, NewOutput>(
      (input) async {
        final output = await getOrThrow(input);
        return await callback(output);
      },
    );
  }
}
