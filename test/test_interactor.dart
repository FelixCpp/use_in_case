import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class TestInteractor extends ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}

final class WaitingInteractor
    extends ParameterizedResultInteractor<Duration, int> {
  @override
  Future<int> execute(Duration input) async {
    return Future.delayed(input, () => input.inMilliseconds);
  }
}

final class ThrowingInteractor extends Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    throw Exception("This is an expected exception");
  }
}
