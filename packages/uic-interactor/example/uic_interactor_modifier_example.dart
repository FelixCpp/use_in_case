import 'package:uic_interactor/uic_interactor.dart';

class CustomExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final String name;
  const CustomExtension({
    required super.modifier,
    required this.name,
  });

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return super.buildStream().skip(1);
  }

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      print('$name: $event');
      callback(event, details);
    });
  }
}

class CustomExtensionBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final String name;
  const CustomExtensionBuilder({required this.name});

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return CustomExtension(modifier: modifier, name: name);
  }
}

class CustomInteractor extends Interactor {
  const CustomInteractor();

  @override
  Future<void> execute(Nothing _) async {}
}

Future<void> main() async {
  const interactor = CustomInteractor();

  final _ = await interactor(nothing)
      .modifier(const CustomExtensionBuilder(name: 'Ext1'))
      .get();
}
