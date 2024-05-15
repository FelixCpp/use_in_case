import 'dart:math';

import 'package:use_in_case/src/event.dart';
import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/invocator.dart';
import 'package:use_in_case/src/modifier.dart';

final class CustomModifier<Parameter, Result> extends ChainedModifier<Parameter, Result> {
  const CustomModifier(super._modifier);

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return super.buildEventHandler().after((details, event) {
      event.whenOrNull(
        onStart: (parameter) {
          print('${details.calleName} started with $parameter -->');
        },
        onResult: (result) => print('<-- ${details.calleName} succeeded with $result'),
        onException: (exception) => print('<-- ${details.calleName} failed with $exception'),
      );
    });
  }
}

extension<Parameter, Result> on Invocator<Parameter, Result> {
  Invocator<Parameter, Result> myCustomModifier() {
    return modifier((modifier) => CustomModifier(modifier));
  }
}

final class HardWorkingInteractor extends PRInteractor<int, double> {
  const HardWorkingInteractor();

  @override
  Future<double> execute(int parameter) {
    return Future.delayed(const Duration(milliseconds: 250), () => parameter + pi - 3.0);
  }
}

void main() async {
  const interactor = HardWorkingInteractor();
  final result = await interactor(3).myCustomModifier().get();
  print('Result: $result');
}
