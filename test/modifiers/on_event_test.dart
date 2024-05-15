import 'package:dartz/dartz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/use_in_case.dart';

final class _TestInteractor extends PRInteractor<int, double> {
  @override
  Future<double> execute(int parameter) async {
    return parameter * 1.5;
  }
}

final class _ThrowingInteractor extends Interactor {
  const _ThrowingInteractor();

  @override
  Future<void> execute(Unit parameter) {
    throw Exception('Expected exception');
  }
}

void main() {
  group('on event modifier', () {
    late PRInteractor<int, double> interactor;

    setUp(() {
      interactor = _TestInteractor();
    });

    test('capture onStart event', () async {
      var parameter = 0;
      await interactor(10).onStart((input) => parameter = input).run();
      expect(parameter, equals(10));
    });

    test('capture onResult event', () async {
      var result = 0.0;
      await interactor(10).onResult((output) => result = output).run();
      expect(result, equals(15.0));
    });

    test('capture onException event', () async {
      const throwingInteractor = _ThrowingInteractor();
      Exception? failure;

      await throwingInteractor(unit)
          .onException((exception) => failure = exception)
          .run();

      expect(
        failure,
        isA<Exception>().having(
          (exception) => exception.toString(),
          'description',
          'Exception: Expected exception',
        ),
      );
    });

    test('capture onEvent event', () async {
      var startCount = 0, resultCount = 0, failureCount = 0;

      await interactor(10).onEvent((event) {
        event.when(
          onStart: (_) => ++startCount,
          onResult: (_) => ++resultCount,
          onException: (_) => ++failureCount,
        );
      }).run();

      expect(startCount, equals(1));
      expect(resultCount, equals(1));
      expect(failureCount, equals(0));
    });
  });
}
