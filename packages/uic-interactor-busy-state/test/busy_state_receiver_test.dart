import 'package:test/test.dart';
import 'package:uic_interactor/src/invocation_configurator.dart';
import 'package:uic_interactor/src/parameterized_result_interactor.dart';
import 'package:uic_interactor/src/util/nothing.dart';
import 'package:uic_interactor_busy_state/src/busy_state_receiver_extension.dart';

final class NoThrowInteractor extends ResultInteractor<int> {
  const NoThrowInteractor();

  @override
  Future<int> execute(Nothing input) {
    return Future.delayed(const Duration(milliseconds: 25), () => 31);
  }
}

final class ThrowInteractor extends ResultInteractor<int> {
  const ThrowInteractor();

  @override
  Future<int> execute(Nothing input) {
    return Future.error(Exception('Some Message'));
  }
}

void main() {
  group('run interactor with single receiver modifier', () {
    late List<bool> emittions;

    setUp(() {
      emittions = List.empty(growable: true);
    });

    test('should succeed with 31 as result and emit [true, false]', () async {
      const ResultInteractor<int> interactor = NoThrowInteractor();
      final result =
          await interactor(nothing).receiveBusyStateChange(emittions.add).get();

      expect(result, equals(31));
      expect(emittions, orderedEquals([true, false]));
    });

    test('should fail and emit [true, false]', () async {
      const ResultInteractor<int> interactor = ThrowInteractor();

      try {
        await interactor(nothing).receiveBusyStateChange(emittions.add).get();
        fail('No exception caught');
      } catch (exception) {
        expect(exception, isException);
      } finally {
        expect(emittions, orderedEquals([true, false]));
      }
    });
  });

  group('run interactor with multiple receiver modifiers', () {
    late List<bool> emittions;

    setUp(() {
      emittions = List.empty(growable: true);
    });

    test(
      'should succeed with 31 as result and emit [2x true, 2x false]',
      () async {
        const ResultInteractor<int> interactor = NoThrowInteractor();
        final result = await interactor(nothing)
            .receiveBusyStateChange(emittions.add)
            .receiveBusyStateChange(emittions.add)
            .get();

        expect(result, equals(31));
        expect(emittions, orderedEquals([true, true, false, false]));
      },
    );

    test('should fail and emit [3x true, 3x false]', () async {
      const ResultInteractor<int> interactor = ThrowInteractor();
      try {
        await interactor(nothing)
            .receiveBusyStateChange(emittions.add)
            .receiveBusyStateChange(emittions.add)
            .receiveBusyStateChange(emittions.add)
            .get();

        fail('No exception caught');
      } catch (exception) {
        expect(exception, isException);
      } finally {
        expect(
          emittions,
          orderedEquals([true, true, true, false, false, false]),
        );
      }
    });
  });
}
