import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  @override
  Future<void> runUnsafe(Unit input) async {
    print('Goodbye!');
  }
}

void main() async {
  final interactor = Printer();
  await interactor.before((input) async => print('Hello!')).run(unit); // Hello!, Goodbye!
}
