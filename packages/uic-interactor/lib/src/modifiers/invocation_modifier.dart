import 'package:uic_interactor/src/invocation_event.dart';

abstract interface class InvocationModifier<Input, Output> {
  Stream<InvocationEvent<Input, Output>> buildStream();
}
