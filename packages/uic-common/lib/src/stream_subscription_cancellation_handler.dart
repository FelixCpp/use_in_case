import 'dart:async';

mixin class StreamSubscriptionCancellationHandler {
  final List<StreamSubscription> _subscriptions = List.empty(growable: true);

  Future<void> cancelSubscriptions() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
  }

  void _addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}

extension CancellableSubscription on StreamSubscription {
  void canceledBy(StreamSubscriptionCancellationHandler handler) {
    handler._addSubscription(this);
  }
}
