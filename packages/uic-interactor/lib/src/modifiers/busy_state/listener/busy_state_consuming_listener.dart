import 'dart:async';

import 'package:meta/meta.dart';
import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/src/modifiers/busy_state/listener/busy_state_listener.dart';

class BusyStateConsumingListener
    with StreamSubscriptionCancellationHandler
    implements BusyStateListener {
  final StreamController<bool> _controller;
  final bool _automaticallyCloseSubscriptions;

  @visibleForTesting
  Stream<bool> get stream => _controller.stream;

  BusyStateConsumingListener({
    StreamController<bool>? controller,
    final bool automaticallyCloseSubscriptions = true,
  })  : _controller = controller ?? StreamController<bool>(),
        _automaticallyCloseSubscriptions = automaticallyCloseSubscriptions;

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
    _controller.add(true);
  }

  @override
  void removeLoader() {
    _controller.add(false);
  }

  @override
  Future<void> release() async {
    if (_automaticallyCloseSubscriptions) {
      await cancelSubscriptions();
    }

    return _controller.close();
  }
}
