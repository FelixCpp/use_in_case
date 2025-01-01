import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Extension that adds the `after` method to the [ParameterizedResultInteractor] class.
/// This method allows you to execute a callback after the interactor's [execute] method.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .after((output) => print('Output: $output'))
///   .run(input);
/// ```
extension After<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> after(
    FutureOr<void> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      final output = await execute(input);
      await callback(output);
      return output;
    });
  }
}
