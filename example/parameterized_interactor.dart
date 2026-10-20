import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class Printer extends ParameterizedInteractor<String> {
  @override
  FutureOr<void> execute(String input) {
    print(input);
  }
}

void main() async {
  final interactor = Printer();
  await interactor.run('Hello, World!'); // Hello, World!
}
