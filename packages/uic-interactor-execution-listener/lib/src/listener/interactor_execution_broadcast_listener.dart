import 'dart:async';

import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_listener.dart';

class InteractorExecutionBroadcastListener
    implements InteractorExecutionListener {
  final StreamController<int> _controller;
  int _counter = 0;

  InteractorExecutionBroadcastListener({
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
