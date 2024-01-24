import 'dart:async';

import 'package:uic_interactor_busy_state/src/listener/busy_state_listener.dart';

class BusyStateBufferingListener implements BusyStateListener {
  final StreamController<int> _controller;
  int _counter = 0;

  BusyStateBufferingListener({
    StreamController<int>? controller,
  }) : _controller = controller ?? StreamController<int>();

  @override
  Stream<bool> get isLoading => _controller.stream.map((event) => event > 0);

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
