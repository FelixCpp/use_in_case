import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Runner implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit _) {
    print('Hello, World!');
  }
}

void main() async {
  final interactor = Runner();
  await interactor.run(unit); // Hello, World!
}
