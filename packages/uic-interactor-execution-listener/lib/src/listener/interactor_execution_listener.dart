import 'dart:async';

abstract interface class InteractorExecutionListener {
  Stream<bool> get isLoading;

  void addLoader();
  void removeLoader();
}
