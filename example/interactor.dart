import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class Runner implements Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    print('Hello, World!');
  }
}

void main() async {
  final interactor = Runner();
  await interactor.run(); // Hello, World!
}
