import 'package:test/test.dart';
import 'package:use_in_case/use_in_case.dart';

final class _TestInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}

void main() {
  group('After', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = _TestInteractor();
    });

    test('should call after with produced output', () async {
      late final int output;

      await sut.after((producedOutput) async {
        output = producedOutput;
      }).run("123");

      expect(output, equals(123));
    });

    test('should not call after due to exception', () async {
      var callCount = 0;

      await expectLater(
        () => sut.after((producedOutput) async {
          ++callCount;
        }).runUnsafe("testNaN"),
        throwsA(isA<FormatException>()),
      );

      expect(callCount, equals(0));
    });
  });
}
