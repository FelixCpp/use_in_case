import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class Converter implements ParameterizedResultInteractor<String, int> {
  @override
  FutureOr<int> getOrThrow(String input) {
    return int.parse(input);
  }
}

void main() async {
  final interactor = Converter();
  final result = await interactor.getOrThrow('42');
  print(result); // 42
}
