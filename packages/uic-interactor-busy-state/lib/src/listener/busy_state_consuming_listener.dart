import 'dart:async';

import 'package:uic_interactor_busy_state/uic_interactor_busy_state.dart';

class BusyStateConsumingListener implements BusyStateListener {
  final StreamController<bool> _controller;

  BusyStateConsumingListener({
    StreamController<bool>? controller,
  }) : _controller = controller ?? StreamController<bool>();

  @override
  Stream<bool> get isLoading => _controller.stream;

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
