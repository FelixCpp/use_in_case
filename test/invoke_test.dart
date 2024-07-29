import 'package:test/test.dart';
import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/invoke.dart';

import 'test_interactor.dart';

final class _RunInteractor
    implements ParameterizedResultInteractor<String, int> {
  var called = false;

  @override
  Future<int> execute(String input) async {
    called = true;
    return int.parse(input);
  }
}

void main() {
  group('run', () {
    late _RunInteractor interactor;

    setUp(() {
      interactor = _RunInteractor();
    });

    test('should invoke execute method', () async {
      await interactor.run('42');
      expect(interactor.called, isTrue);
    });

    test('should invoke execute method and ignore exception', () async {
      await interactor.run('bruh');
      expect(interactor.called, isTrue);
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
}
