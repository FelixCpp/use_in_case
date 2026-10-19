import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class GetPiInteractor extends ResultInteractor<double> {
  @override
  FutureOr<double> getOrThrow() {
    return 3.141592;
  }
}

void main() async {
  final interactor = GetPiInteractor();
  final pi = await interactor.map((output) => output.toInt()).getOrThrow();
  print('Pi is $pi');
}
