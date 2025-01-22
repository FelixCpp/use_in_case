import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

/// Extension that adds the `map` method to the [ParameterizedResultInteractor] class.
/// This method allows you to map the output of the interactor to a new output.
/// The callback will be called with the output of the interactor and should return the new output.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .map((output) => output.toString())
///   .run(input);
/// ```
extension Map<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, NewOutput> map<NewOutput>(
      FutureOr<NewOutput> Function(Output) callback) {
    return InlinedParameterizedResultInteractor<Input, NewOutput>(
        (input) async {
      final output = await runUnsafe(input);
      return await callback(output);
    });
  }
}
