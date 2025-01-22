import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension Eventually<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> eventually(
      FutureOr<void> Function() callback) {
    return InlinedParameterizedResultInteractor((input) {
      return Future(() => runUnsafe(input)).whenComplete(callback);
    });
  }
}
