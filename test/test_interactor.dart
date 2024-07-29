import 'package:use_in_case/use_in_case.dart';

final class TestInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}
