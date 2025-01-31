import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

class SynchronizeInteractor implements Interactor {
  @override
  FutureOr<void> runUnsafe(Unit input) {
    // .. Perform real synchronization here ...
    return Future.delayed(Duration(milliseconds: 100));
  }
}

void main() async {
  final interactor = SynchronizeInteractor();

  await interactor
      .runAtLeast(Duration(milliseconds: 1500))
      .measureTime((duration) => print('Synchronization took $duration'))
      .run(unit);
}
