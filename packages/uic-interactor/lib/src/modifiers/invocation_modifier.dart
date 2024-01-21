import 'package:uic_interactor/src/invocation_event.dart';

abstract interface class InvocationModifier {
  Stream<InvocationEvent> buildStream();
}
