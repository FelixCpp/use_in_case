import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/intercept.dart';
import 'package:use_in_case/src/invoke.dart';

class StringToIntInteractor
    implements ParameterizedResultInteractor<String, int> {
  @override
  Future<int> getOrThrow(String input) async {
    return int.parse(input);
  }
}

Future<void> main() {
  final interactor = StringToIntInteractor();
  final iterable = ['1', 'Hello', 'World', '42'];

  return Future.forEach(iterable, (input) async {
    return interactor
        .typedIntercept<FormatException>(
          (exception) => print('Formatting error $exception!'),
          consume: true,
        )
        .intercept((exception) => print('Unexpected error $exception!'))
        .run(input);
  });
}
