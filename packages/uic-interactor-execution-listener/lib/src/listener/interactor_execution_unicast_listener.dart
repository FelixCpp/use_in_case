import 'dart:async';

import 'package:uic_interactor_execution_listener/src/listener/interactor_execution_listener.dart';

class InteractorExecutionUnicastListener
    implements InteractorExecutionListener {
  final StreamController<bool> _controller;

  InteractorExecutionUnicastListener({
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
}
