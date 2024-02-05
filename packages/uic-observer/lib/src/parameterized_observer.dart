import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uic_common/uic_common.dart';

abstract base class ParameterizedObserver<Input, Output>
    with StreamSubscriptionCancellationHandler {
  final StreamController<Input> _controller;

  Stream<Output> get stream => _controller.stream
      .distinct()
      .flatMap((event) => transform(event))
      .distinct();

  ParameterizedObserver([StreamController<Input>? controller])
      : _controller = controller ?? StreamController.broadcast();

  OwnedStreamSubscription<Output> listen(
    void Function(Output) onData, {
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

  void emit(Input event) {
    _controller.add(event);
  }

  Future<dynamic> closeStream() async {
    await cancelSubscriptions();
    return _controller.close();
  }

  @protected
  @visibleForOverriding
  Stream<Output> transform(Input input);
}

typedef Observer<Output> = ParameterizedObserver<Nothing, Output>;
