import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Extension that adds the `before` method to the [ParameterizedResultInteractor] class.
/// This method allows you to execute a callback before the interactor's [runUnsafe] method.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .before((input) => print('Input: $input'))
///   .run(input);
/// ```
extension Before<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> before(
      FutureOr<void> Function(Input) callback) {
    return InlinedParameterizedResultInteractor((input) async {
      await callback(input);
      return runUnsafe(input);
    });
  }
}
