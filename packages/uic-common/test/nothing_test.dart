import 'package:test/test.dart';
import 'package:uic_common/uic_common.dart';

void main() {
  group('nothing.toString()', () {
    test('should equal \'()\'', () {
      expect(nothing.toString(), '()');
    });
  });
}
