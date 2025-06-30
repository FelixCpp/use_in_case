import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

class ToIntInteractor implements ParameterizedResultInteractor<String, int> {
  ToIntInteractor();

  @override
  FutureOr<int> getOrThrow(String input) {
    return int.parse(input);
  }
}

void main() async {
  final intToString = ToIntInteractor();
  final intToStringModifier = intToString.continueWith((either) => either.fold(
        (exception) => 'Failed with: $exception',
        (output) => 'Succeeded with: $output',
      ));

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
