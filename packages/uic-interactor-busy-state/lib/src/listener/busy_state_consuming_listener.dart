import 'dart:async';

import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor_busy_state/uic_interactor_busy_state.dart';

class BusyStateConsumingListener
    with StreamSubscriptionCancellationHandler
    implements BusyStateListener {
  final StreamController<bool> _controller;

  BusyStateConsumingListener({
    StreamController<bool>? controller,
  }) : _controller = controller ?? StreamController<bool>();

  @override
  OwnedStreamSubscription<bool> listen(
    void Function(bool) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final subscription = _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    )..canceledBy(this);

    return OwnedStreamSubscription(subscription);
  }

  @override
  void addLoader() {
    _controller.add(true);
  }

  @override
  void removeLoader() {
    _controller.add(false);
  }

  @override
  Future<void> release() {
    return _controller.close();
  }
}
