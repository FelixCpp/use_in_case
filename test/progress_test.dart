import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:use_in_case/use_in_case.dart';

final class _TestProgressInteractor
    extends ParameterizedResultProgressInteractor<String, int, double> {
  @override
  Future<int> runUnsafe(String input) async {
    for (var i = 0; i < 10; i++) {
      await emitProgress(i / 10);
    }

    return int.parse(input);
  }
}

void main() {
  group('progress', () {
    late _TestProgressInteractor sut;

    setUp(() {
      sut = _TestProgressInteractor();
    });

    test('should emit progress in order', () async {
      final progress = <double>[];

      final result = await sut
          .receiveProgress((p) async => progress.add(p))
          .getOrThrow('42');

      expect(progress,
          orderedEquals([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]));
      expect(result, equals(42));
    });

    test('should emit progress and then throw', () async {
      final progress = <double>[];

      await expectLater(
        sut
            .receiveProgress((p) async => progress.add(p))
            .getOrThrow('ksdhfbruh'),
        throwsFormatException,
      );

      expect(progress,
          orderedEquals([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]));
    });

    test('should throw on receiveProgress', () async {
      final progress = <double>[];

      await expectLater(
        () => sut
            .receiveProgress((p) => throw Exception('brrrruuuuh'))
            .getOrThrow('42'),
        throwsA(
          isA<Exception>().having(
            (exception) => exception.toString(),
            'error Text',
            contains('brrrruuuuh'),
          ),
        ),
      );

      expect(progress, isEmpty);
    });
  });
}
