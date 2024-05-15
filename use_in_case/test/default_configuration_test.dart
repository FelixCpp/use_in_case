import 'dart:async';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/use_in_case.dart';

final class _InteractorWithTimeout extends PRInteractor<Duration, double> {
  @override
  Future<double> execute(Duration parameter) async {
    return Future.delayed(parameter, () => parameter.inMilliseconds * 1.5);
  }

  @override
  Invocator<Duration, double> Function(Invocator<Duration, double>)
      get configure => (invocation) {
            return invocation.timeout(Duration(milliseconds: 250));
          };
}

final class _InteractorWithComplexConfig extends PRInteractor<Duration, int> {
  final void Function(bool) onBusyStateChange;

  const _InteractorWithComplexConfig(this.onBusyStateChange);

  @override
  Future<int> execute(Duration parameter) async {
    return Future.delayed(parameter, () => 42);
  }

  @override
  Invocator<Duration, int> Function(Invocator<Duration, int>) get configure =>
      (invocation) {
        return invocation
            .timeout(Duration(milliseconds: 150))
            .receiveBusyState(onBusyStateChange);
      };
}

void main() {
  group('default configuration interactor', () {
    late PRInteractor<Duration, double> interactor;

    setUp(() {
      interactor = _InteractorWithTimeout();
    });

    test('should timeout after 0.25 seconds', () {
      expect(
        interactor(Duration(milliseconds: 500)).get(),
        throwsA(
          isA<TimeoutException>().having(
            (timeout) => timeout.duration,
            'duration',
            Duration(milliseconds: 250),
          ),
        ),
      );
    });
  });

  group('complex configuration interactor', () {
    late PRInteractor<Duration, int> interactor;
    late List<bool> states;

    setUp(() {
      states = List.empty(growable: true);
      interactor = _InteractorWithComplexConfig(states.add);
    });

    test('should emit [true, false] into list of busy states', () async {
      await interactor(Duration.zero).run();
      expect(states, orderedEquals([true, false]));
    });

    test('should emit [true, false] into list of busy states even when failing',
        () async {
      final future =
          interactor(Duration(milliseconds: 300)).get().whenComplete(() {
        expect(states, orderedEquals([true, false]));
      });

      expect(future, throwsA(isA<TimeoutException>()));
    });
  });
}
