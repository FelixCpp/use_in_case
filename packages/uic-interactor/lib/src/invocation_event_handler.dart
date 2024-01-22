import 'package:uic_interactor/src/util/invocation_details.dart';
import 'package:uic_interactor/src/util/invocation_event.dart';

typedef InvocationEventHandler<Input, Output> = void Function(
  InvocationEvent<Input, Output> event,
  InvocationDetails details,
);
