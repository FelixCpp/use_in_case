import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('map', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should map output to same type', () async {
      final result =
          await sut.map((output) async => output * 2).getOrThrow('2');

      expect(result, 4);
    });

    test('should map output to different type', () async {
      final result =
          await sut.map((output) async => output * 2.0).getOrThrow('2');

      expect(result, 4.0);
      expect(result, isA<double>());
    });

    test('should cast from int to dynamic', () async {
      final result = sut.cast<dynamic>().getOrThrow('2');
      expect(result, isA<dynamic>());
    });

    test('should throw type casting exception', () async {
      final result = sut.cast<String>().getOrThrow('2');
      await expectLater(result, throwsA(isA<TypeError>()));
    });
  });

  group('continueWith', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should continue with output', () async {
      final result = await sut
          .continueWith((either) => either.fold(
                (e) => 'Error',
                (o) => 'Output',
              ))
          .getOrThrow('2');

      expect(result, 'Output');
    });

    test('should continue with error', () async {
      final result = await sut
          .continueWith((either) => either.fold(
                (e) => 'Error',
                (o) => 'Output',
              ))
          .getOrThrow('NaN');

      expect(result, 'Error');
    });

    test('should have correct exception type', () async {
      final result = await sut
          .continueWith((either) => either.fold(
                (e) => e,
                (o) => 'Output',
              ))
          .getOrThrow('NaN');

      await expectLater(result, isA<FormatException>());
    });
  });
}
