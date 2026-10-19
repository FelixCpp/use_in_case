import 'dart:async';
import 'dart:math';

import 'package:use_in_case/use_in_case.dart';

final class Printer extends Interactor {
  final random = Random();

  @override
  FutureOr<void> getOrThrow() {
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
      .run(); // Hello!, Goodbye!
}
