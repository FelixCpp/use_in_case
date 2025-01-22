import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/invoke.dart';

import 'test_interactor.dart';

final class _RunInteractor implements ParameterizedResultInteractor<String, int> {
  var called = false;

  @override
  Future<int> runUnsafe(String input) async {
    called = true;
    return int.parse(input);
  }
}

final class _ThrowErrorInteracctor implements ResultInteractor<int> {
  @override
  Future<int> runUnsafe(Unit unit) async {
    throw ArgumentError('Invalid argument');
  }
}

void main() {
  group('run', () {
    late _RunInteractor sut;

    setUp(() {
      sut = _RunInteractor();
    });

    test('should invoke execute method', () async {
      await sut.run('42');
      expect(sut.called, isTrue);
    });

    test('should invoke execute method and ignore exception', () async {
      await sut.run('bruh');
      expect(sut.called, isTrue);
    });
  });

  group('runUnsafe', () {
    late _RunInteractor interactor;

    setUp(() {
      interactor = _RunInteractor();
    });

    test('should invoke execute method', () async {
      await interactor.run('42');
      expect(interactor.called, isTrue);
    });

    test('should invoke execute method and ignore exception', () async {
      await expectLater(
        () => interactor.runUnsafe('bruh'),
        throwsA(isA<FormatException>()),
      );

      expect(interactor.called, isTrue);
    });
  });

  group('getOrThrow', () {
    late ParameterizedResultInteractor<String, int> interactor;

    setUp(() {
      interactor = TestInteractor();
    });

    test('should return the result of the interactor', () async {
      final result = await interactor.getOrThrow('42');
      expect(result, 42);
    });

    test('should throw FormatException', () {
      expect(() => interactor.getOrThrow('42.0'), throwsFormatException);
    });
  });

  group('getOrNull', () {
    late ParameterizedResultInteractor<String, int> interactor;

    setUp(() {
      interactor = TestInteractor();
    });

    test('should return the result of the interactor', () async {
      final result = await interactor.getOrNull('42');
      expect(result, 42);
    });

    test('should throw FormatException', () async {
      expect(await interactor.getOrNull('42.0'), isNull);
    });
  });

  group('getOrElse', () {
    late ParameterizedResultInteractor<String, int> interactor;

    setUp(() {
      interactor = TestInteractor();
    });

    test('should return the result of the interactor', () async {
      final result = await interactor.getOrElse('42', (_) async => -1);
      expect(result, 42);
    });

    test('should throw FormatException', () async {
      expect(await interactor.getOrElse('42.0', (_) async => -1), equals(-1));
    });
  });

  group('invocation with errors', () {
    late ParameterizedResultInteractor<Unit, int> interactor;

    setUp(() {
      interactor = _ThrowErrorInteracctor();
    });

    test('should throw ArgumentError', () {
      expect(() => interactor.getOrThrow(unit), throwsArgumentError);
    });

    test('should return null', () async {
      expect(interactor.getOrNull(unit), completion(isNull));
    });

    test('should not return fallback value due to error not exception', () {
      expect(() => interactor.getOrElse(unit, (_) => -1), throwsArgumentError);
    });
  });
}
