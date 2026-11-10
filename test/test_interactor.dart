import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class TestInteractor implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> execute(String input) async {
    return int.parse(input);
  }
}

class WaitingInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  @override
  Future<int> execute(Duration input) async {
    return Future.delayed(input, () => input.inMilliseconds);
  }
}

class ThrowingInteractor implements Interactor {
  @override
  FutureOr<void> execute(NoInput _) {
    throw Exception("This is an expected exception");
  }
}
