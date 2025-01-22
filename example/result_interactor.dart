import 'package:dartz/dartz.dart';
import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/invoke.dart';

final class Counter implements ResultInteractor<int> {
  int _counter = 0;

  @override
  Future<int> runUnsafe(Unit _) async {
    return _counter++;
  }
}

void main() async {
  final interactor = Counter();

  final result = await interactor.getOrThrow(unit);
  print(result); // 0

  final result2 = await interactor.getOrThrow(unit);
  print(result2); // 1
}
