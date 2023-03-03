/// Horrible clean code - https://www.computerenhance.com/p/clean-code-horrible-performance

import 'dart:math';

abstract class Shape {
  Shape();
  double area();
}

class Square extends Shape {
  final double side;

  Square(this.side);

  @override
  double area() => side * side;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

class Triangle extends Shape {
  final double base;
  final double height;

  Triangle(this.base, this.height);

  @override
  double area() => base * height / 2;
}

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double area() => radius * radius * 3.14;
}

double accumAreaVTable(List<Shape> shapes) {
  double area = 0;
  for (var shape in shapes) {
    area += shape.area();
  }
  return area;
}

enum ShapeType {
  square,
  rectangle,
  triangle,
  circle,
}

class UnionShape {
  final ShapeType type;
  final double width;
  final double height;

  UnionShape.square(this.width)
      : type = ShapeType.square,
        height = 0;
  UnionShape.rectangle(this.width, this.height) : type = ShapeType.rectangle;
  UnionShape.triangle(this.width, this.height) : type = ShapeType.triangle;
  UnionShape.circle(this.width)
      : type = ShapeType.circle,
        height = 0;

  double area() {
    switch (type) {
      case ShapeType.square:
        return width * width;
      case ShapeType.rectangle:
        return width * height;
      case ShapeType.triangle:
        return width * height / 2;
      case ShapeType.circle:
        return width * width * 3.14;
    }
  }
}

double accumAreaSwitch(List<UnionShape> shapes) {
  double area = 0;
  for (var shape in shapes) {
    area += shape.area();
  }
  return area;
}

class ShapeWithRate {
  final double width;
  final double height;
  final double rate;

  ShapeWithRate(this.width, this.height, this.rate);
}

final rate = <ShapeType, double>{
  ShapeType.square: 1,
  ShapeType.rectangle: 1,
  ShapeType.triangle: 0.5,
  ShapeType.circle: 3.14,
};

double calculateArea(ShapeWithRate shape) {
  return shape.width * shape.height * shape.rate;
}

double accumAreaInline(List<ShapeWithRate> shapes) {
  double area = 0;
  for (var shape in shapes) {
    area += calculateArea(shape);
  }
  return area;
}

void main(List args) {
  var loop = 0;
  try {
    loop = int.parse(args[0]);
  } catch (e) {
    print('Usage: horrible_clean_code <loop>');
    return;
  }
  final vtbls = List.generate(
    loop,
    (i) => [
      Square(Random().nextDouble()),
      Rectangle(Random().nextDouble(), Random().nextDouble()),
      Triangle(Random().nextDouble(), Random().nextDouble()),
      Circle(Random().nextDouble()),
    ],
  ).expand((element) => element).toList()
    // shuffle
    ..sort((a, b) => Random().nextBool() ? 1 : -1);

  final sw = Stopwatch()..start();
  var _ = accumAreaVTable(vtbls);
  sw.stop();
  final vtblTime = sw.elapsedMicroseconds;

  print('Clean - Elapsed time: ${vtblTime}us');

  final unions = List.generate(
    loop,
    (i) => [
      UnionShape.square(Random().nextDouble()),
      UnionShape.rectangle(Random().nextDouble(), Random().nextDouble()),
      UnionShape.triangle(Random().nextDouble(), Random().nextDouble()),
      UnionShape.circle(Random().nextDouble()),
    ],
  ).expand((element) => element).toList()
    // shuffle
    ..sort((a, b) => Random().nextBool() ? 1 : -1);
  sw.reset();
  sw.start();
  _ = accumAreaSwitch(unions);
  sw.stop();
  final unionTime = sw.elapsedMicroseconds;

  print('Switch - Elapsed time: ${unionTime}us, ${vtblTime / unionTime}x');

  final simple = List.generate(
    loop,
    (i) => [
      () {
        final side = Random().nextDouble();
        return ShapeWithRate(side, side, rate[ShapeType.square]!);
      }(),
      ShapeWithRate(Random().nextDouble(), Random().nextDouble(),
          rate[ShapeType.rectangle]!),
      ShapeWithRate(Random().nextDouble(), Random().nextDouble(),
          rate[ShapeType.triangle]!),
      () {
        final radius = Random().nextDouble();
        return ShapeWithRate(radius, radius, rate[ShapeType.circle]!);
      }(),
    ],
  ).expand((element) => element).toList()
    // shuffle
    ..sort((a, b) => Random().nextBool() ? 1 : -1);

  sw.reset();
  sw.start();
  _ = accumAreaInline(simple);
  sw.stop();
  final simpleTime = sw.elapsedMicroseconds;
  print('Inline - Elapsed time: ${simpleTime}us, ${vtblTime / simpleTime}x');
}
