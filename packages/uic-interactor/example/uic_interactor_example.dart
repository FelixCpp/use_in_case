/* import 'package:uic_interactor/uic_interactor.dart';

class DivideByTwoInteractor implements ParameterizedResultInteractor<int, int> {
  const DivideByTwoInteractor();

  @override
  Future<int> execute(int input) async {
    return input ~/ 2;
  }
}

Future<void> main() async {
  const divideByTwo = DivideByTwoInteractor();
  const value = 502;

  final result = await divideByTwo(value).get();
  print('$value ~/ 2 = $result');
}
 */