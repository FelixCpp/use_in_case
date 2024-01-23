import 'package:test/test.dart';
import 'package:uic_interactor/uic_interactor.dart';

class CountingExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  var startCount = 0;
  var successCount = 0;
  var failureCount = 0;

  CountingExtension({required super.modifier});

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      event.when(
        onStart: (_) => ++startCount,
        onSuccess: (_) => ++successCount,
        onFailure: (_) => ++failureCount,
      );

      callback(event, details);
    });
  }
}

class CountingExtensionBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  late CountingExtension<Input, Output> ext;
  CountingExtensionBuilder();

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    ext = CountingExtension(modifier: modifier);
    return ext;
  }
}

class SkipExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  const SkipExtension({required super.modifier});

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream().skip(1);
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

class SkipExtensionBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  const SkipExtensionBuilder();

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return SkipExtension(modifier: modifier);
  }
}

class TestInteractor extends Interactor {
  const TestInteractor();

  @override
  Future<void> execute(Nothing input) async {}
}

void main() {
  group('run interactor with custom extension', () {
    test('should call extension method twice', () async {
      final builder = CountingExtensionBuilder<Nothing, void>();
      const interactor = TestInteractor();

      final _ = await interactor(nothing).modifier(builder).get();

      expect(builder.ext.startCount, equals(1));
      expect(builder.ext.successCount, equals(1));
      expect(builder.ext.failureCount, equals(0));
    });

    test('should skip onStart event', () async {
      final builder = CountingExtensionBuilder<Nothing, void>();
      const interactor = TestInteractor();

      final _ = await interactor(nothing)
          .modifier(const SkipExtensionBuilder())
          .modifier(builder)
          .get();

      expect(builder.ext.startCount, equals(0));
      expect(builder.ext.successCount, equals(1));
      expect(builder.ext.failureCount, equals(0));
    });
  });
}
