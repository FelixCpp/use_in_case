import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Type alias for the busy state.
///
/// TODO(Felix): This should be an inline-class when upgrading to dart 3.3.0.
/// extension type const IsBusy(bool value) implements bool {}
typedef IsBusy = bool;

/// Extension that adds the `watchBusyState` method to the [ParameterizedResultInteractor] class.
/// This method allows you to watch the busy state of the interactor.
/// The callback will be called with `true` when the interactor is busy and `false` when it's done.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .watchBusyState((isBusy) => print('Is busy: $isBusy'))
///   .run(input);
/// ```
extension BusyState<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> watchBusyState(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        await callback(true);
        return await execute(input);
      } finally {
        await callback(false);
      }
    });
  }
}
