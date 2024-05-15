import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/src/busy_state_modifier.dart';
import 'package:use_in_case/src/interactor.dart';

final class _DefaultInteractor extends PInteractor<bool> {
  @override
  Future<void> execute(bool parameter) async {
    if (parameter) {
      throw Exception('expected exception');
    }
  }
}

void main() {
  group('single busy state modifier', () {
    late PInteractor<bool> interactor;

    setUp(() {
      interactor = _DefaultInteractor();
    });

    test('should emit [true, false] into list when succeeding', () async {
      final states = <bool>[];
      await interactor(false).receiveBusyState(states.add).run();
      expect(states, orderedEquals([true, false]));
    });

    test('should emit [true, false] into list when failing', () async {
      final states = <bool>[];
      await interactor(true).receiveBusyState(states.add).run();
      expect(states, orderedEquals([true, false]));
    });
  });

  group('multiple busy state modifier', () {
    late PInteractor<bool> interactor;

    setUp(() {
      interactor = _DefaultInteractor();
    });

    test('should emit [true, true, false, false] into list when succeeding', () async {
      final states = <bool>[];
      await interactor(false).receiveBusyState(states.add).receiveBusyState(states.add).run();
      expect(states, orderedEquals([true, true, false, false]));
    });

    test('should emit [true, true, false, false] into list when failing', () async {
      final states = <bool>[];
      await interactor(true).receiveBusyState(states.add).receiveBusyState(states.add).run();
      expect(states, orderedEquals([true, true, false, false]));
    });
  });
}
