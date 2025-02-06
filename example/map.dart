import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

class GetPiInteractor implements ResultInteractor<double> {
  @override
  FutureOr<double> getOrThrow(Unit input) {
    return 3.141592;
  }
}

void main() async {
  final interactor = GetPiInteractor();
  final pi = await interactor.map((output) => output.toInt()).getOrThrow(unit);
  print('Pi is $pi');
}
