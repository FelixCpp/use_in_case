import 'dart:async';

import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/outcome.dart';

/// Adds output transformations and outcome handling to all interactors.
extension MapExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// Transforms the output of this interactor.
  ParameterizedResultInteractor<Input, NewOutput> map<NewOutput>(
    FutureOr<NewOutput> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor(
      (input) async => callback(await invoke(input)),
    );
  }

  /// Casts the output type without transforming the produced value.
  ParameterizedResultInteractor<Input, NewOutput> cast<NewOutput>() =>
      map((output) => output as NewOutput);

  /// Continues with a sealed success or failure outcome.
  ParameterizedResultInteractor<Input, NewOutput> continueWith<NewOutput>(
    FutureOr<NewOutput> Function(InteractorOutcome<Output>) callback,
  ) {
    return InlinedParameterizedResultInteractor((input) async {
      late final InteractorOutcome<Output> outcome;
      try {
        outcome = InteractorSuccess(await invoke(input));
      } on Exception catch (exception) {
        outcome = InteractorFailure(exception);
      }
      return callback(outcome);
    });
  }
}
