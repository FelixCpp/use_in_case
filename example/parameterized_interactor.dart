import 'package:use_in_case/use_in_case.dart';

final class Printer implements ParameterizedInteractor<String> {
  @override
  Future<void> runUnsafe(String input) async {
    print(input);
  }
}

void main() async {
  final interactor = Printer();
  await interactor.run('Hello, World!'); // Hello, World!
}
