import 'dart:async';

import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor_busy_state/src/listener/busy_state_listener.dart';

class BusyStateBufferingListener
    with StreamSubscriptionCancellationHandler
    implements BusyStateListener {
  final StreamController<int> _controller;
  int _counter = 0;

  BusyStateBufferingListener({
    StreamController<int>? controller,
  }) : _controller = controller ?? StreamController<int>();

  @override
  OwnedStreamSubscription<bool> listen(
    void Function(bool) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final subscription = _controller.stream.map((event) => event > 0).listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        )..canceledBy(this);

    return OwnedStreamSubscription(subscription);
  }

  @override
  void addLoader() {
    _controller.add(++_counter);
  }

  @override
  void removeLoader() {
    _controller.add(--_counter);
  }

  @override
  Future<void> release() {
    return _controller.close();
  }
}
