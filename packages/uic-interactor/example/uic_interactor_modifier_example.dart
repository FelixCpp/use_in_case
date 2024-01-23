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
    return super.buildEventHandler((event, details) {
      //event.whenOrNull(onStart: (_) => print('Name: $name'));
      print('$name: $event');
      callback(event, details);
    });
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
      .apply((modifier) => CustomExtension(modifier: modifier, name: 'Bla'))
      .apply((modifier) => CustomExtension(modifier: modifier, name: 'Blu'))
      .get();
}
