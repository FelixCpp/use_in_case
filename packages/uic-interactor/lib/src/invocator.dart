import 'dart:async';

import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/modifier.dart';
import 'package:use_in_case/src/on_event_collector.dart';

final class Invocator<Parameter, Result> {
  final Modifier<Parameter, Result> _modifier;
  final EventDetails _details;

  const Invocator({
    required Modifier<Parameter, Result> modifier,
    required EventDetails details,
  })  : _modifier = modifier,
        _details = details;

  Future<Result> get() {
    final completer = Completer<Result>();
    onResult(completer.complete).onException(completer.completeError).run();
    return completer.future;
  }

  Future<Result?> getOrNull() {
    return get().then((value) => Future<Result?>.value(value)).onError((_, __) => null);
  }

  Future<Result> getOrElse(Result Function() fallback) {
    return get().onError((_, __) => fallback());
  }

  Future<void> run() async {
    final stream = _modifier.buildStream();
    final handler = _modifier.buildEventHandler();

    final completer = Completer();

    StreamSubscription? subscription;
    subscription = stream.listen(
      (event) {
        handler(_details, event);
        event.whenOrNull(
          onResult: completer.complete,
          onException: completer.complete,
        );
      },
      cancelOnError: true,
    );

    return completer.future.whenComplete(() {
      subscription?.cancel();
    });
  }
}

extension InvocatorWithModification<Parameter, Result> on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> modifier(ModifierBuilder<Parameter, Result> builder) {
    return Invocator(modifier: builder(_modifier), details: _details);
  }
}
