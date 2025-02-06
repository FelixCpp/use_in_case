import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    print('Goodbye!');
  }
}

void main() {
  final interactor = Printer();
  interactor
      .intercept((exception) => print('Hello!'))
      .run(unit); // Hello!, Goodbye!
}
