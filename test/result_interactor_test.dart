import 'dart:async';

import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

final class _NoInputInteractor extends ResultInteractor<int> {
  @override
  FutureOr<int> getOrThrow() => 42;
}

final class _FailingNoInputInteractor extends ResultInteractor<int> {
  @override
  FutureOr<int> getOrThrow() => throw const FormatException('invalid');
}

final class _NoInputProgressInteractor
    extends ResultProgressInteractor<int, int> {
  @override
  FutureOr<int> getOrThrow() async {
    await emitProgress(1);
    await emitProgress(2);
    return 42;
  }
}

void main() {
  group('no-input result interactor', () {
    test('supports chained modifiers and invocation without a sentinel',
        () async {
      final calls = <String>[];
      final sut = _NoInputInteractor();

      final result = await sut
          .before((_) => calls.add('before'))
          .map((value) => value + 1)
          .after((value) => calls.add('after:$value'))
          .getOrThrow();

      expect(result, 43);
      expect(calls, ['before', 'after:43']);
    });

    test('continueWith exposes sealed success and failure outcomes', () async {
      final success = await _NoInputInteractor()
          .continueWith((outcome) => switch (outcome) {
                InteractorSuccess(:final value) => value,
                InteractorFailure() => -1,
              })
          .getOrThrow();

      expect(success, 42);

      final failure = await _FailingNoInputInteractor()
          .continueWith((outcome) => switch (outcome) {
                InteractorSuccess() => 'success',
                InteractorFailure(:final exception) => exception.runtimeType,
              })
          .getOrThrow();

      expect(failure, FormatException);
    });

    test('can invoke no-input interactors without a placeholder input',
        () async {
      await _NoInputInteractor().run();
      expect(await _NoInputInteractor().getOrNull(), 42);
      expect(await _NoInputInteractor().getOrElse((_) => -1), 42);
    });
  });

  test('no-input progress interactors emit progress', () async {
    final values = <int>[];
    final result = await _NoInputProgressInteractor()
        .receiveProgress(values.add)
        .getOrThrow();

    expect(result, 42);
    expect(values, [1, 2]);
  });
}
