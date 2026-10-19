import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

final class Counter extends ResultInteractor<int> {
  int _counter = 0;

  @override
  FutureOr<int> getOrThrow() {
    return _counter++;
  }
}

void main() async {
  final interactor = Counter();

  final result = await interactor.getOrThrow();
  print(result); // 0

  final result2 = await interactor.getOrThrow();
  print(result2); // 1
}
