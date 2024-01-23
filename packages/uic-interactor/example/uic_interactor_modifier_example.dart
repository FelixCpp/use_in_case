import 'package:uic_interactor/uic_interactor.dart';

class CustomExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final String name;
  const CustomExtension({
    required super.modifier,
    required this.name,
  });

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

class SkipOnStartEventExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  const SkipOnStartEventExtension({
    required super.modifier,
  });

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream().skip(1);
  }
}

class CustomInteractor implements Interactor {
  const CustomInteractor();

  @override
  Future<void> execute(Nothing _) async {}
}

Future<void> main() async {
  const interactor = CustomInteractor();

  final _ = await interactor(nothing)
      .modifier((modifier) => SkipOnStartEventExtension(modifier: modifier))
      .modifier((modifier) => CustomExtension(modifier: modifier, name: 'Ext1'))
      .get();
}
