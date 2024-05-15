import 'package:dartz/dartz.dart';
import 'package:uic_interactor/uic-interactor.dart';

final class SomeInteractor extends RInteractor<String> {
  const SomeInteractor();

  @override
  Future<String> execute(Unit parameter) {
    return Future.delayed(const Duration(seconds: 2), () => 'Done');
  }

  @override
  Invocator<Unit, String> Function(Invocator<Unit, String>) get configure =>
      (invocation) {
        return invocation.timeout(const Duration(seconds: 1));
      };
}

void main() async {
  const interactor = SomeInteractor();
  final result = await interactor(unit).getOrNull();
  print('Result should be null doe to timeout: $result');
}
