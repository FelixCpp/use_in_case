import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    print('Working...');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .busyStateChange((isBusy) => print('Busy: $isBusy'))
      .run(unit); // Busy: true, Working..., Busy: false
}
