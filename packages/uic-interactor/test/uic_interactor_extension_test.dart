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

class TestInteractor implements Interactor {
  const TestInteractor();

  @override
  Future<void> execute(Nothing input) async {}
}

void main() {
  group('run interactor with custom extension', () {
    test('should call extension method twice', () async {
      late CountingExtension<Nothing, void> ext;
      const interactor = TestInteractor();

      final _ = await interactor(nothing).modifier((modifier) {
        ext = CountingExtension(modifier: modifier);
        return ext;
      }).get();

      expect(ext.startCount, equals(1));
      expect(ext.successCount, equals(1));
      expect(ext.failureCount, equals(0));
    });

    test('should skip onStart event', () async {
      late CountingExtension<Nothing, void> ext;
      const interactor = TestInteractor();

      final _ = await interactor(nothing)
          .modifier((modifier) => SkipExtension(modifier: modifier))
          .modifier((modifier) {
        ext = CountingExtension(modifier: modifier);
        return ext;
      }).get();

      expect(ext.startCount, equals(0));
      expect(ext.successCount, equals(1));
      expect(ext.failureCount, equals(0));
    });
  });
}
