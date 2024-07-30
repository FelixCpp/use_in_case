import 'dart:async';

import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('recover', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should not need to recover without exception', () async {
      final result = await sut.recover((_) async => 0).getOrThrow('42');
      expect(result, equals(42));
    });

    test('should recover from exception with -1', () async {
      final result = await sut.recover((_) async => -1).getOrThrow('42.0');
      expect(result, equals(-1));
    });
  });

  group('typedRecover', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should not need to recover without exception', () async {
      final result = await sut
          .typedRecover<FormatException>((_) async => 0)
          .getOrThrow('42');

      expect(result, equals(42));
    });

    test('should recover from exception with -1', () async {
      final result = await sut
          .typedRecover<FormatException>((_) async => -1)
          .getOrThrow('42.0');
      expect(result, equals(-1));
    });

    test('should not recover from exception due to type missmatch', () async {
      expect(
          () => sut
              .typedRecover<TimeoutException>((_) async => -1)
              .getOrThrow('42.0'),
          throwsFormatException);
    });
  });
}
