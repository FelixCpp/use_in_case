import 'package:use_in_case/use_in_case.dart';

final class Converter implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}

void main() async {
  final interactor = Converter();
  final result = await interactor.execute('42');
  print(result); // 42
}
