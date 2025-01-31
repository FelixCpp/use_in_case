import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

typedef Action = void Function();
typedef RepeatParams = ({int times, Action action});

final class RepeatInteractor implements ParameterizedInteractor<RepeatParams> {
  @override
  FutureOr<void> runUnsafe(RepeatParams input) {
    for (var i = 0; i < input.times; i++) {
      input.action();
    }
  }
}

void main() async {
  final interactor = RepeatInteractor();

  await interactor
      .measureTime((duration) => print('Repetitions took $duration'))
      .run((times: 10, action: () => print('Hello')));
}
