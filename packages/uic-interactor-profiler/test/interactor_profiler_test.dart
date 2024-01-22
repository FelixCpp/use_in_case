import 'dart:async';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/profiler_extension.dart';

class MyInteractor implements ParameterizedResultInteractor<int, int> {
  @override
  Future<int> execute(int input) {
    return Future.delayed(Duration(milliseconds: 250), () => input);
  }
}

class ThrowingInteractor implements ParameterizedResultInteractor {
  @override
  Future execute(input) {
    throw Exception('Some Error');
  }
}

class DefaultLogger implements InvocationEventProfiler {
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
  test('Should succeed with result and method counts', () async {
    final logger = DefaultLogger();
    final interactor = MyInteractor();
    final result = await interactor(120).profiler(logger).get();

    expect(result, equals(120));
    expect(logger.startCount, equals(1));
    expect(logger.successCount, equals(1));
    expect(logger.failureCount, equals(0));
  });

  test('Should succeed sum up method calls', () async {
    final logger = DefaultLogger();
    final interactor = MyInteractor();
    final result =
        await interactor(120).profiler(logger).profiler(logger).get();

    expect(result, equals(120));
    expect(logger.startCount, equals(2));
    expect(logger.successCount, equals(2));
    expect(logger.failureCount, equals(0));
  });

  test('Should throw exception and log error', () async {
    final logger = DefaultLogger();
    final interactor = ThrowingInteractor();

    try {
      await interactor(120).profiler(logger).get();

      fail('No exception has been thrown');
    } on Exception catch (_) {
      expect(logger.startCount, equals(1));
      expect(logger.successCount, equals(0));
      expect(logger.failureCount, equals(1));
    } catch (exception) {
      fail('Unexpected exception type has been thrown');
    }
  });
}
