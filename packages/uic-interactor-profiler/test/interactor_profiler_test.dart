import 'dart:async';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/profiler_extension.dart';

class MyInteractor extends ParameterizedResultInteractor<int, int> {
  @override
  Future<int> execute(int input) {
    return Future.delayed(Duration(milliseconds: 250), () => input);
  }
}

class ThrowingInteractor extends ParameterizedResultInteractor {
  @override
  Future execute(input) {
    throw Exception('Some Error');
  }
}

class DefaultProfiler implements InvocationEventProfiler {
  int startCount = 0;
  int successCount = 0;
  int failureCount = 0;

  @override
  void onInvocationStart<T>({
    required InvocationDetails details,
    required T input,
  }) {
    ++startCount;
  }

  @override
  void onInvocationSuccess<T>({
    required InvocationDetails details,
    required Duration elapsedTime,
    required T output,
  }) {
    ++successCount;
  }

  @override
  void onInvocationFailure({
    required InvocationDetails details,
    required Duration elapsedTime,
    required Exception exception,
  }) {
    ++failureCount;
  }
}

void main() {
  group('run interactor with single profiler modifier', () {
    test('should continue with method calls equal to one', () async {
      final profiler = DefaultProfiler();
      final interactor = MyInteractor();
      final result = await interactor(120).profiler(profiler).get();

      expect(result, equals(120));
      expect(profiler.startCount, equals(1));
      expect(profiler.successCount, equals(1));
      expect(profiler.failureCount, equals(0));
    });

    test('should continue with method calls equal to one and result', () async {
      final completer = Completer<int>();
      final profiler = DefaultProfiler();
      final interactor = MyInteractor();
      interactor(120).profiler(profiler).configure((event) {
        event.whenOrNull(
          onSuccess: (output) => completer.complete(output),
        );
      }).run();

      expect(await completer.future, equals(120));
      expect(profiler.startCount, equals(1));
      expect(profiler.successCount, equals(1));
      expect(profiler.failureCount, equals(0));
    });

    test(
      'should continue with method calls equal to one and failure',
      () async {
        final completer = Completer<int>();
        final profiler = DefaultProfiler();
        final interactor = ThrowingInteractor();
        interactor(120).profiler(profiler).configure((event) {
          event.whenOrNull(
            onFailure: (exception) => completer.completeError(exception),
          );
        }).run();

        expect(completer.future, throwsA(isException));

        try {
          await completer.future;
          expect(profiler.startCount, equals(1));
          expect(profiler.successCount, equals(0));
          expect(profiler.failureCount, equals(1));
        } catch (_) {}
      },
    );
  });

  group('run interactor with multiple profiler modifier', () {
    test('should continue with method calls equal to three', () async {
      final profiler = DefaultProfiler();
      final interactor = MyInteractor();
      final result = await interactor(120)
          .profiler(profiler)
          .profiler(profiler)
          .profiler(profiler)
          .get();

      expect(result, equals(120));
      expect(profiler.startCount, equals(3));
      expect(profiler.successCount, equals(3));
      expect(profiler.failureCount, equals(0));
    });

    test('should continue with method calls equal to four and result',
        () async {
      final completer = Completer<int>();
      final profiler = DefaultProfiler();
      final interactor = MyInteractor();
      interactor(120)
          .profiler(profiler)
          .profiler(profiler)
          .profiler(profiler)
          .profiler(profiler)
          .configure((event) {
        event.whenOrNull(
          onSuccess: (output) => completer.complete(output),
        );
      }).run();

      expect(await completer.future, equals(120));
      expect(profiler.startCount, equals(4));
      expect(profiler.successCount, equals(4));
      expect(profiler.failureCount, equals(0));
    });

    test(
      'should continue with method calls equal to two and failure',
      () async {
        final completer = Completer<int>();
        final profiler = DefaultProfiler();
        final interactor = ThrowingInteractor();
        interactor(120)
            .profiler(profiler)
            .profiler(profiler)
            .configure((event) {
          event.whenOrNull(
            onFailure: (exception) => completer.completeError(exception),
          );
        }).run();

        expect(completer.future, throwsA(isException));

        try {
          await completer.future;
          expect(profiler.startCount, equals(2));
          expect(profiler.successCount, equals(0));
          expect(profiler.failureCount, equals(2));
        } catch (_) {}
      },
    );
  });
}
