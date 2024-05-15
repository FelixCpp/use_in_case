import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

///
/// Invocation events that are yielded during the execution flow
///
@freezed
sealed class Event<Parameter, Result> with _$Event<Parameter, Result> {
  const factory Event.onStart(Parameter parameter) = _OnStart;
  const factory Event.onResult(Result result) = _OnResult;
  const factory Event.onException(Exception exception) = _OnException;
}

///
/// Additional event details
///
typedef EventDetails = ({String calleName});

///
/// Type definition of a callback
///
typedef EventHandler<Parameter, Result> = void Function(EventDetails, Event<Parameter, Result>);

///
/// Additional methods that build different kinds of ordered execution in order to
/// invoke the corresponding callbacks at the right time.
///
extension EventHandlerBuildHelpers<Parameter, Result> on EventHandler<Parameter, Result> {
  EventHandler<Parameter, Result> wrap(EventHandler<Parameter, Result> handler) {
    return (details, event) {
      current() => this(details, event);
      next() => handler(details, event);

      event.maybeWhen(
        onStart: (event) {
          next();
          current();
        },
        orElse: () {
          current();
          next();
        },
      );
    };
  }

  EventHandler<Parameter, Result> before(EventHandler<Parameter, Result> handler) {
    return (details, event) {
      handler(details, event);
      this(details, event);
    };
  }

  EventHandler<Parameter, Result> after(EventHandler<Parameter, Result> handler) {
    return handler.before(this);
  }
}
