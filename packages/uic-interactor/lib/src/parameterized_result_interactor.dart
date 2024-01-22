import 'package:uic_interactor/src/util/nothing.dart';

abstract interface class ParameterizedResultInteractor<Input, Output> {
  Future<Output> execute(Input input);
}

typedef Interactor = ParameterizedResultInteractor<Nothing, Nothing>;
typedef ResultInteractor<Output>
    = ParameterizedResultInteractor<Nothing, Output>;
typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, Nothing>;
