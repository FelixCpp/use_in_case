// Define an interactor that does something. He must extend/implement a type mentioned above.
import 'package:use_in_case/use_in_case.dart';

final class StringToIntConverter
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> runUnsafe(String input) async {
    return int.parse(input);
  }
}

void main() async {
  final interactor = StringToIntConverter();
  final result = await interactor.getOrThrow('42');
  print(result); // 42
}
