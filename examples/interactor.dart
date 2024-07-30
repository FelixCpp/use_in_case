import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class Runner implements Interactor {
  @override
  Future<void> execute(Unit _) async {
    print('Hello, World!');
  }
}

void main() async {
  final interactor = Runner();
  await interactor.run(unit); // Hello, World!
}
