import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class Printer extends Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    print('Hello!');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .after((input) async => print('Goodbye!'))
      .run(); // Hello!, Goodbye!
}
