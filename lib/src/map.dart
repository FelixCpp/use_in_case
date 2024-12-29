import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

extension Map<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, NewOutput> map<NewOutput>(
    FutureOr<NewOutput> Function(Output) callback,
  ) {
    return InlinedParameterizedResultInteractor<Input, NewOutput>(
      (input) async {
        final output = await execute(input);
        return await callback(output);
      },
    );
  }
}
