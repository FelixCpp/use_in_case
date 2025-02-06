import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// Type alias for the busy state.
///
/// TODO(Felix): This should be an inline-class when upgrading to dart 3.3.0.
/// extension type const IsBusy(bool value) implements bool {}
typedef IsBusy = bool;

/// This extension provides methods to observe the busy state of an interactor.
///
/// Provided methods:
///   - [busyStateChange]
///   - [emitBusyStateChange]
extension BusyStateExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Calls the given callback with the busy state of the interactor.
  /// The callback will be called with `true` when the interactor is
  /// busy and `false` when it's done.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .busyStateChange((isBusy) => print('Is busy: $isBusy'))
  ///   .run(input);
  /// ```
  ///
  /// see [emitBusyStateChange], [IsBusy]
  ParameterizedResultInteractor<Input, Output> busyStateChange(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      try {
        await callback(true);
        return await getOrThrow(input);
      } finally {
        await callback(false);
      }
    });
  }

  /// Emits the busy state into the given [StreamController].
  /// The stream will emit `true` when the interactor is busy and
  /// `false` when it's done.
  ///
  /// Note that you need to close the stream controller on your own
  /// when you're done. Closing the [StreamController] during an
  /// invocation of the interactor may lead to unexpected behavior
  /// or errors.
  /// To avoid this, you could chain the [eventually] method after this
  /// one that will close the stream controller when the interactor is
  /// done. This way you can ensure that the stream controller is closed
  /// nonetheless of the outcome of the interactor. This is especially
  /// useful when the interactor throws an exception.
  ///
  /// An example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// final streamController = StreamController<IsBusy>();
  ///
  /// final subscription = streamController.stream.listen((isBusy) {
  ///   print('Stream: $isBusy');
  /// });
  ///
  /// await interactor
  ///   .emitBusyStateChange(streamController)
  ///   .eventually(() {
  ///     subscription.cancel();
  ///     streamController.close();
  ///   })
  ///   .run(input);
  /// ```
  ///
  /// see [eventually], [busyStateChange], [StreamController]
  ParameterizedResultInteractor<Input, Output> emitBusyStateChange(
    StreamController<IsBusy> controller,
  ) {
    return busyStateChange(controller.add);
  }

  /// @Deprecated: Deprecated since use_in_case 1.3.0.
  /// Use [busyStateChange] instead.
  @Deprecated('Use busyStateChange instead')
  ParameterizedResultInteractor<Input, Output> watchBusyState(
    FutureOr<void> Function(IsBusy) callback,
  ) {
    return busyStateChange(callback);
  }
}
