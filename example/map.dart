import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class GetPiInteractor extends ResultInteractor<double> {
  @override
  FutureOr<double> execute(NoInput _) {
    return 3.141592;
  }
}

void main() async {
  final interactor = GetPiInteractor();
  final pi = await interactor.map((output) => output.toInt()).getOrThrow();
  print('Pi is $pi');
}
