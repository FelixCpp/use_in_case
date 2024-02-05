import 'package:uic_observer/uic_observer.dart';

final class CountingObserver extends ParameterizedObserver<int, int> {
  @override
  Stream<int> transform(int input) {
    return Stream.periodic(const Duration(seconds: 1), (value) => value)
        .take(input);
  }
}

void main() async {
  final observer = CountingObserver();
  observer.listen(print);
  observer.emit(5);

  await observer.closeStream();
}
