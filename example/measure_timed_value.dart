import 'dart:async';
import 'dart:math';

import 'package:use_in_case/use_in_case.dart';

class Accumulator implements ParameterizedResultInteractor<Iterable<num>, num> {
  @override
  FutureOr<num> getOrThrow(Iterable<num> input) async {
    num result = 0;

    for (final number in input) {
      result += (number / 3.141592 * 84.1028 * 0.25).floorToDouble() * 1.65;
      result -= number * 0.7812;
    }

    return result;
  }
}

void main() async {
  final interactor = Accumulator();

  final rng = Random();
  final randomLists = List.generate(
    10000,
    (_) => List.generate(1000, (_) => rng.nextDouble() * 3.141592),
  );

  final expandedLists = randomLists.expand((e) => e);

  var totalDuration = Duration.zero;
  num totalSum = 0;
  for (final list in randomLists) {
    final (duration, result) =
        await interactor.measureTimedValueOnSuccess().getOrThrow(list);

    totalSum += result;
    totalDuration += duration;
  }

  print('-- Using for-each loop --');
  print('Total sum: $totalSum');
  print('Total duration: $totalDuration');

  final (duration, result) =
      await interactor.measureTimedValue().getOrThrow(expandedLists);

  print('-- Using expand --');
  print('Total sum: $result');
  print('Total duration: $duration');
}
