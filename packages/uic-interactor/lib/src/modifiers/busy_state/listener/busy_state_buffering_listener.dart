import 'dart:async';

import 'package:meta/meta.dart';
import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/src/modifiers/busy_state/listener/busy_state_listener.dart';

class BusyStateBufferingListener
    with StreamSubscriptionCancellationHandler
    implements BusyStateListener {
  final StreamController<int> _controller;
  int _counter = 0;

  @visibleForTesting
  Stream<bool> get stream => _controller.stream.map((event) => event > 0);

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
    final subscription = stream.listen(
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
  Future<void> release() async {
    await cancelSubscriptions();
    return _controller.close();
  }
}
