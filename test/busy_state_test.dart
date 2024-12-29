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
}
