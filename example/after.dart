import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Printer implements Interactor {
  @override
  Future<void> runUnsafe(Unit input) async {
    print('Hello!');
  }
}

void main() async {
  final interactor = Printer();
  await interactor
      .after((input) async => print('Goodbye!'))
      .run(unit); // Hello!, Goodbye!
}
