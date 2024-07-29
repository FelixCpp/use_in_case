import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('watch busy state', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should invoke callback in correct order', () async {
      final order = <bool>[];

      await sut
          .watchBusyState((isBusy) async => order.add(isBusy))
          .getOrThrow('42');

      expect(order, orderedEquals([true, false]));
    });

    test('should invoke callback in correct order with exception', () async {
      final order = <bool>[];

      await expectLater(
        () => sut
            .watchBusyState((isBusy) async => order.add(isBusy))
            .getOrThrow('NaN'),
        throwsA(isA<FormatException>()),
      );

      expect(order, orderedEquals([true, false]));
    });
  });

  group('debounceBusyState', () {
    late ParameterizedResultInteractor<Duration, int> interactor;

    setUp(() {
      interactor = WaitingInteractor();
    });

    test('should debounce busy state', () async {
      final order = <bool>[];

      await interactor
          .debounceBusyState(
            (isBusy) async => order.add(isBusy),
            duration: const Duration(milliseconds: 200),
          )
          .getOrThrow(const Duration(milliseconds: 100));

      expect(order, orderedEquals([]));
    });

    test('should debounce busy state with exception', () async {
      DateTime? published;

      final start = DateTime.now();
      final result = await interactor
          .debounceBusyState(
            (isBusy) async => published = isBusy ? DateTime.now() : published,
            duration: const Duration(milliseconds: 100),
          )
          .getOrThrow(const Duration(milliseconds: 300));

      expect(result, equals(300));
      expect(published, isNotNull);
      expect(
        published!.difference(start),
        greaterThanOrEqualTo(
          const Duration(milliseconds: 100),
        ),
      );
    });
  });
}
