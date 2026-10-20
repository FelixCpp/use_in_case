import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

final class ToIntInteractor extends ParameterizedResultInteractor<String, int> {
  ToIntInteractor();

  @override
  FutureOr<int> execute(String input) {
    return int.parse(input);
  }
}

void main() async {
  final intToString = ToIntInteractor();
  final intToStringModifier =
      intToString.continueWith((outcome) => switch (outcome) {
            InteractorFailure(:final exception) => 'Failed with: $exception',
            InteractorSuccess(:final value) => 'Succeeded with: $value',
          });

  {
    final result = await intToStringModifier.getOrThrow('42');

    // Succeeded with: 42
    print(result);
  }

  {
    final result = await intToStringModifier.getOrThrow('NaN');

    // Failed with: FormatException: Invalid radix-10 number (at character 1)
    print(result);
  }
}
