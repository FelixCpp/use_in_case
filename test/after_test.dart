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

    test('should call "after" once', () async {
      var callCount = 0;

      final result = await sut.after((_) async {
        callCount++;
      }).getOrThrow('42');

      expect(callCount, equals(1));
      expect(result, equals(42));
    });

    test('should call "after" with correct parameter', () async {
      var output = 0;

      final result = await sut
          .after((producedOutput) => output = producedOutput)
          .getOrThrow('42');

      expect(output, equals(42));
      expect(result, equals(42));
    });

    test('should call "after" in correct order', () async {
      final order = <int>[];

      final result = await sut
          .after((_) => order.add(0))
          .after((_) => order.add(1))
          .getOrThrow('42');

      expect(order, orderedEquals([0, 1]));
      expect(result, equals(42));
    });

    test('should call "after" until first throws', () async {
      var callCount = 0;

      await expectLater(
        () => sut
            .after((_) => callCount++)
            .after((_) => throw Exception())
            .after((_) => callCount++)
            .getOrThrow('42'),
        throwsException,
      );

      expect(callCount, equals(1));
    });
  });
}
