import 'package:test/test.dart';
import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/uic_interactor.dart';

class PrintExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final String name;

  const PrintExtension({
    required super.modifier,
    required this.name,
  });

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      print(name);
      callback(event, details);
    });
  }
}

class PrintExtensionBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final String name;
  const PrintExtensionBuilder(this.name);

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return PrintExtension(modifier: modifier, name: name);
  }
}

class MyInteractor extends Interactor {
  const MyInteractor();

  @override
  Future<void> execute(Nothing input) async {}

  @override
  List<InvocationModifierBuilder<Nothing, void>> get modifierBuilders => [
        PrintExtensionBuilder('Test 1'),
        PrintExtensionBuilder('Test 2'),
      ];
}

void main() {
  test('bla', () async {
    const interactor = MyInteractor();
    final _ = await interactor(nothing).get();
  });
}
