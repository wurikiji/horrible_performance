#include <algorithm>
#include <iostream>
#include <map>
#include <random>
#include <vector>

using namespace std;

// declare class 'shape' with virtual function 'area' returns double
class shape {
 public:
  virtual double area() = 0;
};

// declare class 'square' with constructor and function 'area'
class square : public shape {
 public:
  square(double s) : side(s) {}
  double area() { return side * side; }

 private:
  double side;
};

// declare class 'circle' with constructor and function 'area'
class circle : public shape {
 public:
  circle(double r) : radius(r) {}
  double area() { return 3.14 * radius * radius; }

 private:
  double radius;
};

// declare class 'rectangle' with constructor and function 'area'
class rectangle : public shape {
 public:
  rectangle(double w, double h) : width(w), height(h) {}
  double area() { return width * height; }

 private:
  double width;
  double height;
};

// declare class 'triangle' with constructor and function 'area'
class triangle : public shape {
 public:
  triangle(double b, double h) : base(b), height(h) {}
  double area() { return 0.5 * base * height; }

 private:
  double base;
  double height;
};

// declare function accumlate all area
double accumulate(vector<shape*>& shapes) {
  double total = 0;
  for (int i = 0; i < shapes.size(); i++) {
    total += shapes[i]->area();
  }
  return total;
}

// declare Shape Type enum
enum ShapeType { SQUARE, CIRCLE, RECTANGLE, TRIANGLE };

// declase UnionShape class with width, height, type
class UnionShape {
 public:
  // constructor
  UnionShape(double w, double h, ShapeType t) : width(w), height(h), type(t) {}
  double width;
  double height;
  ShapeType type;
};

// declare function accumlate all area of UnionShape
double accumulate(vector<UnionShape*>& shapes) {
  double total = 0;
  for (int i = 0; i < shapes.size(); i++) {
    switch (shapes[i]->type) {
      case SQUARE:
        total += shapes[i]->width * shapes[i]->width;
        break;
      case CIRCLE:
        total += 3.14 * shapes[i]->width * shapes[i]->width;
        break;
      case RECTANGLE:
        total += shapes[i]->width * shapes[i]->height;
        break;
      case TRIANGLE:
        total += 0.5 * shapes[i]->width * shapes[i]->height;
        break;
    }
  }
  return total;
}

map<ShapeType, double> rate{
    {SQUARE, 1},
    {CIRCLE, 3.14},
    {RECTANGLE, 1},
    {TRIANGLE, 0.5},
};

class ShapeWithRate {
 public:
  double width;
  double height;
  double rate;

  ShapeWithRate(double width, double height, double rate)
      : width(width), height(height), rate(rate){};
};

double accumulate(vector<ShapeWithRate*>& shapes) {
  double total = 0;
  for (int i = 0; i < shapes.size(); i++) {
    total += shapes[i]->width * shapes[i]->height * shapes[i]->rate;
  }
  return total;
}

// get user input from command line
int main(int argc, char* argv[]) {
  // get int from first argv
  int num = atoi(argv[1]);

  // create vector of shape pointers
  vector<shape*> shapes;

  // create [num] square, circle, rectangle, and triangle
  // with random values
  for (int i = 0; i < num; i++) {
    shapes.push_back(new square(rand() % 100));
    shapes.push_back(new circle(rand() % 100));
    shapes.push_back(new rectangle(rand() % 100, rand() % 100));
    shapes.push_back(new triangle(rand() % 100, rand() % 100));
  }

  // shuffle vector
  auto rng = std::default_random_engine{};
  shuffle(shapes.begin(), shapes.end(), rng);

  // start stop watch
  clock_t start = clock();

  // calculate total area
  volatile double total = accumulate(shapes);

  // stop stop watch
  clock_t end = clock();

  // calculate elapsed clock
  auto elapsed = end - start;
  // convert clock to micro seconds
  elapsed = elapsed * 1000000 / CLOCKS_PER_SEC;

  // print out elapsed clock
  cout << "- Clean - Elapsed time: " << elapsed << "us" << endl;

  // create vector of UnionShape pointers
  vector<UnionShape*> shapes2;

  // create [num] square, circle, rectangle, and triangle UnionShape
  // with random values
  for (int i = 0; i < num; i++) {
    shapes2.push_back(new UnionShape(rand() % 100, 0, SQUARE));
    shapes2.push_back(new UnionShape(rand() % 100, 0, CIRCLE));
    shapes2.push_back(new UnionShape(rand() % 100, rand() % 100, RECTANGLE));
    shapes2.push_back(new UnionShape(rand() % 100, rand() % 100, TRIANGLE));
  }

  // shuffle vector
  shuffle(shapes2.begin(), shapes2.end(), rng);

  // start stop watch
  start = clock();

  // calculate total area
  total = accumulate(shapes2);

  // stop stop watch
  end = clock();

  // calculate elapsed clock
  auto elapsed2 = end - start;
  elapsed2 = elapsed2 * 1000000 / CLOCKS_PER_SEC;

  // print out elapsed clock with ratio of elapsed
  cout << "- Switch - Elapsed time: " << elapsed2 << "us, "
       << double(elapsed) / elapsed2 << "x" << endl;

  // create vector of ShapeWithRate pointers
  vector<ShapeWithRate*> shapes3;

  // create [num] square, circle, rectangle, and triangle ShapeWithRate
  // with random values
  for (int i = 0; i < num; i++) {
    auto width = rand() % 100;
    auto height = rand() % 100;
    shapes3.push_back(new ShapeWithRate(width, width, rate[SQUARE]));
    shapes3.push_back(new ShapeWithRate(width, width, rate[CIRCLE]));
    shapes3.push_back(
        new ShapeWithRate(rand() % 100, rand() % 100, rate[RECTANGLE]));
    shapes3.push_back(
        new ShapeWithRate(rand() % 100, rand() % 100, rate[TRIANGLE]));
  }

  // shuffle vector
  shuffle(shapes3.begin(), shapes3.end(), rng);

  // start stop watch
  start = clock();

  // calculate total area
  total = accumulate(shapes3);

  // stop stop watch
  end = clock();

  // calculate elapsed clock
  auto elapsed3 = end - start;

  // convert clock to micro seconds
  elapsed3 = elapsed3 * 1000000 / CLOCKS_PER_SEC;

  // print out elapsed clock with ratio of elapsed
  cout << "- Inline - Elapsed time: " << elapsed3 << "us, "
       << double(elapsed) / elapsed3 << "x" << endl;

  return 0;
}