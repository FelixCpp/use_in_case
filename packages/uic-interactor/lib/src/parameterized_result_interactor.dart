import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/uic_interactor.dart';

abstract class ParameterizedResultInteractor<Input, Output> {
  const ParameterizedResultInteractor();

  Future<Output> execute(Input input);

  List<InvocationModifierBuilder<Input, Output>> get modifierBuilders =>
      const [];
}

typedef Interactor = ParameterizedResultInteractor<Nothing, void>;
typedef ResultInteractor<Output>
    = ParameterizedResultInteractor<Nothing, Output>;
typedef ParameterizedInteractor<Input>
    = ParameterizedResultInteractor<Input, void>;
