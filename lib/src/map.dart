import 'dart:async';

import 'package:dartz/dartz.dart';
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

  /// This method continues the execution of the interactor regardless of the
  /// result. Whether it succeeded having an output or failed with an
  /// exception, [callback] will be executed with a corresponding
  /// [Either] value.
  ///
  /// This is useful when you want to execute some code after the
  /// interactor finishes depending on the result. In case the output
  /// is really not needed, you should use [eventually] method instead.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// final result = interactor
  ///   .continueWith((either) {
  ///     either.fold(
  ///       (exception) => print('Interactor failed with: $exception'),
  ///       (output) => print('Interactor succeeded with: $output'),
  ///     );
  ///     return 'Done';
  ///   })
  ///   .getOrThrow(input);
  /// ///
  /// print(result); // 'Done'
  /// ```
  ///
  /// see [eventually]
  ParameterizedResultInteractor<Input, NewOutput> continueWith<NewOutput>(
    FutureOr<NewOutput> Function(Either<Exception, Output>) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        final result = await getOrThrow(input);
        return await callback(right(result));
      } on Exception catch (exception) {
        return await callback(left(exception));
      }
    });
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
