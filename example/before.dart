import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class Printer implements Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    print('Goodbye!');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .before((_) async => print('Hello!'))
      .run(); // Hello!, Goodbye!
}
