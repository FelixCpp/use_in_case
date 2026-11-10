import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class Printer implements Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    print('Working...');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .busyStateChange((isBusy) => print('Busy: $isBusy'))
      .run(); // Busy: true, Working..., Busy: false
}
