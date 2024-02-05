import 'package:test/test.dart';
import 'package:uic_observer/uic_observer.dart';

final class CountingObserver extends ParameterizedObserver<int, int> {
  @override
  Stream<int> transform(int input) async* {
    for (var i = 0; i < input; ++i) {
      yield i;
    }
  }
}

void main() {
  group(CountingObserver, () {
    late ParameterizedObserver<int, int> observer;

    setUp(() {
      observer = CountingObserver();
    });

    tearDown(() async {
      await observer.closeStream();
    });

    test('should emit 0 to 4 in order', () {
      expectLater(observer.stream, emitsInOrder({0, 1, 2, 3, 4}));
      observer.emit(5);
    });
  });
}
