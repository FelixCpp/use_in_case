import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('eventually', () {
    late ParameterizedResultInteractor<String, int> interactor;

    setUp(() {
      interactor = TestInteractor();
    });

    test('should be called when no exception is thrown', () async {
      var callCount = 0;
      final result = await interactor.eventually(() async {
        ++callCount;
      }).getOrThrow('42');

      expect(callCount, equals(1));
      expect(result, equals(42));
    });

    test('should be called when an exception is thrown', () async {
      var callCount = 0;

      await expectLater(
        () => interactor.eventually(() async {
          ++callCount;
        }).getOrThrow('42.0'),
        throwsFormatException,
      );

      expect(callCount, equals(1));
    });
  });
}
