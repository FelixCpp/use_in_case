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

      final result = await sut.before((_) async {
        callCount++;
      }).getOrThrow('42');

      expect(callCount, equals(1));
      expect(result, equals(42));
    });

    test('should call "before" with correct parameter', () async {
      var parameter = '';

      final result =
          await sut.before((input) async => parameter = input).getOrThrow('42');

      expect(parameter, equals('42'));
      expect(result, equals(42));
    });

    test('should call "before" in correct order', () async {
      final order = <int>[];

      final result = await sut
          .before((_) async => order.add(1))
          .before((_) async => order.add(0))
          .getOrThrow('42');

      expect(order, orderedEquals([0, 1]));
      expect(result, equals(42));
    });

    test('should call "before" until first throws', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .before((_) async => callCount++)
            .before((_) async => throw Exception())
            .before((_) async => callCount++)
            .getOrThrow('42'),
        throwsException,
      );

      expect(callCount, equals(1));
    });
  });
}
