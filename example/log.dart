import 'dart:async';
import 'dart:io';

import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/invoke.dart';
import 'package:use_in_case/src/log.dart';

final class SquareInteractor
    implements ParameterizedResultInteractor<int, int> {
  @override
  FutureOr<int> execute(int input) {
    return Future.delayed(Duration(seconds: 1), () => input * 2);
  }
}

void main() async {
  final myInteractor = SquareInteractor();

  exitCode = await myInteractor
      .log(
        tag: myInteractor.runtimeType.toString(),
        logStart: (message) => stdout.writeln(message),
        logSuccess: (message) => stdout.writeln(message),
        logError: (message) => stderr.writeln(message),
      )
      .getOrThrow(46);
}
