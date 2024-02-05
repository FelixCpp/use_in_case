import 'dart:async';

class OwnedStreamSubscription<T> {
  final StreamSubscription<T> _subscription;
  const OwnedStreamSubscription(this._subscription);

  void resume() => _subscription.resume();
  void pause([Future<void>? resumeSignal]) => _subscription.pause(resumeSignal);
  void onData(void Function(T)? handleData) => _subscription.onData(handleData);
  void onError(Function? handleError) => _subscription.onError(handleError);
  void onDone(void Function()? handleDone) => _subscription.onDone(handleDone);
  Future<E> asFuture<E>([E? futureValue]) =>
      _subscription.asFuture(futureValue);

  Future<void> forceCancellation() => _subscription.cancel();

  @override
  String toString() => _subscription.toString();
  bool get isPaused => _subscription.isPaused;
}
