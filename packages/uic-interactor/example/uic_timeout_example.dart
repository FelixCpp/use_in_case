import 'package:uic_common/uic_common.dart';
import 'package:uic_interactor/uic_interactor.dart';

class WaitingInteractor extends ResultInteractor<int> {
  const WaitingInteractor();

  @override
  Future<int> execute(Nothing _) {
    return Future.delayed(Duration(milliseconds: 50), () => 99);
  }
}

Future<void> main() async {
  const interactor = WaitingInteractor();

  final result = await interactor(nothing)
      .timeout(Duration(milliseconds: 25))
      .getOrElse(fallback: -1);

  print(result);
}
