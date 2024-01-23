import 'package:uic_interactor/uic_interactor.dart';

abstract interface class InvocationModifierBuilder<Input, Output> {
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  );
}
