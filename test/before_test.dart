import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('before', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should call "before" once', () async {
      var callCount = 0;

      final result = await sut.before((_) {
        callCount++;
      }).getOrThrow('42');

      expect(callCount, equals(1));
      expect(result, equals(42));
    });

    test('should call "before" with correct parameter', () async {
      var parameter = '';

      final result =
          await sut.before((input) => parameter = input).getOrThrow('42');

      expect(parameter, equals('42'));
      expect(result, equals(42));
    });

    test('should call "before" in correct order', () async {
      final order = <int>[];

      final result = await sut
          .before((_) => order.add(1))
          .before((_) => order.add(0))
          .getOrThrow('42');

      expect(order, orderedEquals([0, 1]));
      expect(result, equals(42));
    });

    test('should call "before" until first throws', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .before((_) => callCount++)
            .before((_) => throw Exception())
            .before((_) => callCount++)
            .getOrThrow('42'),
        throwsException,
      );

      expect(callCount, equals(1));
    });
  });
}
