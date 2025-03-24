import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  final random = Random();

  @override
  FutureOr<void> getOrThrow(Unit input) {
    if (random.nextDouble() > 0.5) {
      throw Exception('Random exception');
    }

    print('Goodbye!');
  }
}

void main() {
  final interactor = Printer();
  interactor
      .intercept((exception) => print('Caught $exception!'))
      .run(unit); // Hello!, Goodbye!
}
