import 'package:uic_interactor/src/invocation_details.dart';
import 'package:uic_interactor/src/invocation_event.dart';

abstract interface class InvocationModifier<Input, Output> {
  Stream<InvocationEvent<Input, Output>> buildStream();
  void notify(
    InvocationDetails details,
    InvocationEvent<Input, Output> event,
    void Function(InvocationEvent<Input, Output>) callback,
  );
}
