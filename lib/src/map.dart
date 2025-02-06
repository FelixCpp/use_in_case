import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

/// This extension provides a method to map the output of an interactor.
///
/// Provided methods:
///   - [map]
///   - [cast]
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

  /// This method casts the output of the interactor to the given type [NewOutput].
  /// This is useful when you know that the output of the interactor is of type
  /// [NewOutput] but the type system does not.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// final result = interactor
  ///   .cast<String>()
  ///   .getOrThrow(input);
  /// ```
  ///
  /// If you want to transform not only the type, but the result produced by the
  /// interactor as well, use the [map] method instead.
  ///
  /// see [map]
  ParameterizedResultInteractor<Input, NewOutput> cast<NewOutput>() {
    return map((output) => output as NewOutput);
  }
}
