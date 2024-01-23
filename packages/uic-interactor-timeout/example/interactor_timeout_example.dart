import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_timeout/uic_interactor_timeout.dart';

final class WaitingInteractor
    extends ParameterizedResultInteractor<Duration, int> {
  const WaitingInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 3);
  }
}

Future<void> main() async {
  const interactor = WaitingInteractor();
  final result = await interactor(Duration(milliseconds: 750))
      .timeout(Duration(milliseconds: 150))
      .getOrNull();

  print('Result: $result');
}
