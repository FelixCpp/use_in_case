import 'package:uic_interactor/uic_interactor.dart';

abstract interface class InvocationModifier<Input, Output> {
  Stream<InvocationEvent<Input, Output>> buildStream();

  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  );
}
