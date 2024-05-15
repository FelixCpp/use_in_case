import 'dart:async';

import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/interactor/modifiers/modifier.dart';
import 'package:use_in_case/src/interactor/modifiers/on_event_collector_modifier.dart';

///
/// This class provides the ability to invoke a configured
/// invocation.
/// Methods like [get], [getOrNull], [getOrElse] will return the value
/// in form of a future. [run] can be used in order to simply run the
/// invocation.
///
final class Invocator<Parameter, Result> {
  final Modifier<Parameter, Result> _modifier;
  final EventDetails _details;

  const Invocator({
    required Modifier<Parameter, Result> modifier,
    required EventDetails details,
  })  : _modifier = modifier,
        _details = details;

  ///
  /// Get the value or throw an exception in case the invocation
  /// fails.
  ///
  Future<Result> get() {
    final completer = Completer<Result>();
    onResult(completer.complete).onException(completer.completeError).run();
    return completer.future;
  }

  ///
  /// Get the value or null in case the invocation fails.
  ///
  Future<Result?> getOrNull() {
    return get()
        .then((value) => Future<Result?>.value(value))
        .onError((_, __) => null);
  }

  ///
  /// Get the value or a lazy-evaluated fallback in case the invocation
  /// fails.
  ///
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

///
/// Extend the invocation with a new modifier
///
extension InvocatorWithModification<Parameter, Result>
    on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> modifier(
      ModifierBuilder<Parameter, Result> builder) {
    return Invocator(modifier: builder(_modifier), details: _details);
  }
}
