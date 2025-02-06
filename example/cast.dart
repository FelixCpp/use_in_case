import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

sealed class Shape {}

final class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

final class Square extends Shape {
  final double side;
  Square(this.side);
}

final class ShapeFactory
    implements ParameterizedResultInteractor<String, Shape> {
  @override
  FutureOr<Shape> getOrThrow(String input) {
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
  final factory = ShapeFactory();

  await factory
      .before((input) => print('Creating shape with name $input'))
      .cast<Circle>()
      .after((circle) => print('Circle with radius ${circle.radius}'))
      .getOrThrow('circle');

  await factory
      .before((input) => print('Creating shape with name $input'))
      .cast<Square>()
      .after((square) => print('Square with side ${square.side}'))
      .getOrThrow('square');
}
