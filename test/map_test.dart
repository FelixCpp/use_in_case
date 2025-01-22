import 'package:test/test.dart';
import 'package:use_in_case/src/map.dart';
import 'package:use_in_case/use_in_case.dart';

import 'test_interactor.dart';

void main() {
  group('map', () {
    late ParameterizedResultInteractor<String, int> sut;

    setUp(() {
      sut = TestInteractor();
    });

    test('should map output to same type', () async {
      final result = await sut.map((output) async => output * 2).getOrThrow('2');

      expect(result, 4);
    });

    test('should map output to different type', () async {
      final result = await sut.map((output) async => output * 2.0).getOrThrow('2');

      expect(result, 4.0);
      expect(result, isA<double>());
    });
  });
}
