import 'package:use_in_case/src/interactor.dart';
import 'package:use_in_case/src/timeout_modifier.dart';

final class Calculator extends PRInteractor<CalculatorParams, double> {
  const Calculator();

  @override
  Future<double> execute(CalculatorParams parameter) async {
    return switch (parameter.operator) {
      Operator.add => parameter.a + parameter.b,
      Operator.subtract => parameter.a - parameter.b,
      Operator.multiply => parameter.a * parameter.b,
      Operator.divide => parameter.a / parameter.b,
    };
  }
}

enum Operator {
  add,
  subtract,
  multiply,
  divide;

  @override
  String toString() {
    return switch (this) {
      Operator.add => '+',
      Operator.subtract => '-',
      Operator.multiply => '*',
      Operator.divide => '/',
    };
  }
}

typedef CalculatorParams = ({double a, double b, Operator operator});

void main() async {
  const calculator = Calculator();

  const a = 354.392;
  const b = 124.512;

  for (final operator in Operator.values) {
    final result = await calculator((a: a, b: b, operator: operator)).timeout(const Duration(seconds: 5)).get();
    print('$a $operator $b = $result');
  }
}
