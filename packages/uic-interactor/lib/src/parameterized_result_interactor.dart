import 'package:uic_interactor/src/util/nothing.dart';
import 'package:uic_interactor/uic_interactor.dart';

abstract interface class ParameterizedResultInteractor<Input, Output> {
  Future<Output> execute(Input input);

  ///List<InvocationModifier<Input, Output>> get extensions => [];
}

typedef Interactor = ParameterizedResultInteractor<Nothing, void>;
typedef ResultInteractor<Output>
    = ParameterizedResultInteractor<Nothing, Output>;
typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;
