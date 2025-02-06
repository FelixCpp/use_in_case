import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

final class TestInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> getOrThrow(String input) async {
    return int.parse(input);
  }
}

final class WaitingInteractor
    implements ParameterizedResultInteractor<Duration, int> {
  @override
  Future<int> getOrThrow(Duration input) async {
    return Future.delayed(input, () => input.inMilliseconds);
  }
}

final class ThrowingInteractor implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    throw Exception("This is an expected exception");
  }
}
