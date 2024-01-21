import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/uic_interactor_profiler_base.dart';

class MyInteractor implements ParameterizedResultInteractor<int, int> {
  @override
  Future<int> execute(int input) {
    return Future.delayed(Duration(milliseconds: 250), () => input);
  }
}

void main() {
  test('Should profile', () async {
    final interactor = MyInteractor();
    final result = await interactor(120).profiler().get();
    expect(result, equals(120));
  });
}
