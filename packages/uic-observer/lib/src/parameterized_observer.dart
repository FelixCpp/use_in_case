import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract base class ParameterizedObserver<Input, Output> {
  final StreamController<Input> _controller;

  Stream<Output> get _stream => _controller.stream
      .distinct()
      .flatMap((event) => transform(event))
      .distinct();

  ParameterizedObserver([StreamController<Input>? controller])
      : _controller = controller ?? StreamController.broadcast();

  StreamSubscription<Output> listen(
    void Function(Output) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  void emit(Input event) {
    _controller.add(event);
  }

  Future<dynamic> closeStream() {
    return _controller.close();
  }

  Stream<Output> transform(Input input);
}

final class MyObserver extends ParameterizedObserver<int, int> {
  @override
  Stream<int> transform(int input) {
    return Stream.value(input);
  }
}

void foo() {
  MyObserver observer = MyObserver();
  final subscription = observer.listen((p0) {});
  observer.emit(13);
}
