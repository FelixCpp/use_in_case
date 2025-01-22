import 'package:use_in_case/use_in_case.dart';

final class TestInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> runUnsafe(String input) async {
    return int.parse(input);
  }
}

final class WaitingInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  @override
  Future<int> runUnsafe(Duration input) async {
    return Future.delayed(input, () => input.inMilliseconds);
  }
}
