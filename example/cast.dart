import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

sealed class Shape {}

class Circle implements Shape {
  final double radius;
  const Circle(this.radius);
}

class Square implements Shape {
  final double side;
  const Square(this.side);
}

class ShapeFactory implements ParameterizedResultInteractor<String, Shape> {
  @override
  FutureOr<Shape> execute(String input) {
    if (input == 'circle') {
      return Circle(1.0);
    } else if (input == 'square') {
      return Square(1.0);
    } else {
      throw Exception('Unknown shape');
    }
  }
}

void main() async {
  final shapeFactory = ShapeFactory();

  await shapeFactory
      .before((input) => print('Creating shape with name $input'))
      .cast<Circle>()
      .after((circle) => print('Circle with radius ${circle.radius}'))
      .getOrThrow('circle');

  await shapeFactory
      .before((input) => print('Creating shape with name $input'))
      .cast<Square>()
      .after((square) => print('Square with side ${square.side}'))
      .getOrThrow('square');
}
