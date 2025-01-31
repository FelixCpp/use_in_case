import 'dart:async';
import 'dart:math';

import 'package:use_in_case/use_in_case.dart';

class Accumulator implements ParameterizedResultInteractor<Iterable<num>, num> {
  @override
  FutureOr<num> runUnsafe(Iterable<num> input) async {
    num result = 0;

    for (final number in input) {
      result += number;
    }

    return result;
  }
}

void main() async {
  final interactor = Accumulator();

  final rng = Random();
  final randomLists = List.generate(
    100,
    (_) => List.generate(10, (_) => rng.nextDouble() * 3.141592),
  );

  var totalDuration = Duration.zero;
  num totalSum = 0;
  for (final list in randomLists) {
    final (duration, result) =
        await interactor.measureTimedValue().getOrThrow(list);

    totalSum += result;
    totalDuration += duration;
  }

  print('-- Using for-each loop --');
  print('Total sum: $totalSum');
  print('Total duration: $totalDuration');

  final (duration, result) = await interactor
      .measureTimedValue()
      .getOrThrow(randomLists.expand((e) => e));

  print('-- Using expand --');
  print('Total sum: $result');
  print('Total duration: $duration');
}
