import 'package:dartz/dartz.dart';
import 'package:uic_interactor/src/event.dart';
import 'package:uic_interactor/src/invocator.dart';
import 'package:uic_interactor/src/modifier.dart';

///
/// Generic type interface for interactors.
///
/// [type: Parameter]: Type of the parameter that is passed in when executing
/// [type:   Success]: The success type in case everything went as expected
/// [type:   Failure]: The failure type in case something went wrong.
///
/// Note:
///   Success and failure are explicit outcomes. An exception will be catched on execution
///   but not be represented as a failure type.
///
abstract class ParameterizedResultInteractor<Parameter, Result> {
  const ParameterizedResultInteractor();

  ///
  /// Should executes the interactor based on the given parameter
  ///
  Future<Result> execute(Parameter parameter);

  ///
  /// Configures the default invocation behavior of this interactor.
  /// By default this method simply forwards the default behavior.
  ///
  Invocator<Parameter, Result> Function(Invocator<Parameter, Result>)
      get configure => (invocation) => invocation;
}

///
/// Handy type definition(s)
///
typedef PRInteractor<Parameter, Result>
    = ParameterizedResultInteractor<Parameter, Result>;
typedef ParameterizedInteractor<Parameter>
    = ParameterizedResultInteractor<Parameter, void>;
typedef PInteractor<Parameter> = ParameterizedResultInteractor<Parameter, void>;
typedef ResultInteractor<Result> = ParameterizedResultInteractor<Unit, Result>;
typedef RInteractor<Result> = ParameterizedResultInteractor<Unit, Result>;
typedef Interactor<Result> = ParameterizedResultInteractor<Unit, void>;

///
/// Start the configuration of an invocation for an interactor.
///
/// This method is written as a type extension so derived classes from [ParameterizedResultInteractor]
/// do not need to provide an implementation for this method.
///
extension Invoke<Parameter, Result>
    on ParameterizedResultInteractor<Parameter, Result> {
  Invocator<Parameter, Result> call(Parameter parameter) {
    return configure(
      Invocator(
        modifier:
            _InitialInvocationModifier(parameter: parameter, interactor: this),
        details: (calleName: runtimeType.toString(),),
      ),
    );
  }
}

///
/// Fileprivate implementation of the initial invocation modifier.
///
class _InitialInvocationModifier<Parameter, Result>
    implements Modifier<Parameter, Result> {
  final Parameter parameter;
  final PRInteractor<Parameter, Result> interactor;

  _InitialInvocationModifier({
    required this.parameter,
    required this.interactor,
  });

  @override
  Stream<Event<Parameter, Result>> buildStream() async* {
    try {
      yield Event.onStart(parameter);
      yield Event.onResult(await interactor.execute(parameter));
    } on Exception catch (exception) {
      yield Event.onException(exception);
    }
  }

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return (details, event) {
      // Nothing to do by default.
    };
  }
}
