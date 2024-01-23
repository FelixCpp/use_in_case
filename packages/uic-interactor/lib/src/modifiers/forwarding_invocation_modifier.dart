import 'package:uic_interactor/uic_interactor.dart';

class ForwardingInvocationModifier<Input, Output>
    implements InvocationModifier<Input, Output> {
  final InvocationModifier<Input, Output> modifier;
  const ForwardingInvocationModifier({required this.modifier});

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream();
  }

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      callback(event, details);
    });
  }
}
