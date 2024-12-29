import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  @override
  Future<void> execute(Unit input) async {
    print('Working...');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .watchBusyState((isBusy) async => print('Busy: $isBusy'))
      .run(unit); // Busy: true, Working..., Busy: false
}
