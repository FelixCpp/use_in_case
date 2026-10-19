import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class TestInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> invoke(String input) async {
    return int.parse(input);
  }
}

final class WaitingInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  @override
  Future<int> invoke(Duration input) async {
    return Future.delayed(input, () => input.inMilliseconds);
  }
}

final class ThrowingInteractor extends Interactor {
  @override
  FutureOr<void> getOrThrow() {
    throw Exception("This is an expected exception");
  }
}
