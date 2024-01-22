import 'dart:async';

abstract interface class BusyStateListener {
  Stream<bool> get isLoading;

  void addLoader();
  void removeLoader();
  Future<void> release();
}
