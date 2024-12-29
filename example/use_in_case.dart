// Define an interactor that does something. He must extend/implement a type mentioned above.
import 'package:use_in_case/use_in_case.dart';

final class StringToIntConverter
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}

void main() async {
  final interactor = StringToIntConverter();
  final result = await interactor.execute('42');
  print(result); // 42
}
