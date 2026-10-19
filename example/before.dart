import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class Printer extends Interactor {
  @override
  FutureOr<void> getOrThrow() {
    print('Goodbye!');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .before((_) async => print('Hello!'))
      .run(); // Hello!, Goodbye!
}
