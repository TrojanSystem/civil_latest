import 'package:flutter/material.dart';

class CalculatorClass extends ChangeNotifier {
  double areaRect = 0.0;
  double perimeterRect = 0.0;
  double areaParallelogram = 0.0;
  double perimeterParallelogram = 0.0;
  double areaTriangle = 0.0;
  double perimeterTriangle = 0.0;
  double areaTrapezoid = 0.0;
  double perimeterTrapezoid = 0.0;
  double areaCircle = 0.0;
  double circumferenceCircle = 0.0;
  double volumeRectangularSolid = 0.0;
  double surfaceRectangularSolid = 0.0;
  double volumeCylinder = 0.0;
  double surfaceCylinder = 0.0;
  double volumeSphere = 0.0;
  double surfaceSphere = 0.0;
  double volumePrisms = 0.0;
  double volumePyramid = 0.0;
  double volumeCone = 0.0;

  double rectangleArea(length, width) {
    double areaRect = length * width;
    return areaRect;
  }

  double rectanglePerimeter(length, width) {
    perimeterRect = (2 * length) + (2 * width);
    return perimeterRect;
  }

  double parallelogramArea(base, height) {
    areaParallelogram = base * height;
    return areaParallelogram;
  }

  double prismsVolume(base, height) {
    volumePrisms = base * height;
    return volumePrisms;
  }

  double coneVolume(r, height, h) {
    volumeCone = 0.3333333 * (3.14 * r * r * height);
    return volumeCone;
  }

  double pyramidVolume(base, height) {
    volumePyramid = 0.3333333 * (base * height);
    return volumePyramid;
  }

  double parallelogramPerimeter(base, height) {
    perimeterParallelogram = (2 * base) + (2 * height);
    return perimeterParallelogram;
  }

  double triangleArea(base, height, r) {
    areaTriangle = 0.5 * base * height;
    return areaTriangle;
  }

  double trianglePerimeter(base, height, width) {
    perimeterTriangle = base + height + width;
    return perimeterTriangle;
  }

  double trapezoidArea(h, b2, c, b1) {
    areaTrapezoid = 0.5 * (b1 + b2) * h;
    return areaTrapezoid;
  }

  double trapezoidPerimeter(b1, b2, c, h) {
    perimeterTrapezoid = b1 + b2 + c + h;
    return perimeterTrapezoid;
  }

  double rectagularSolidVolume(length, width, height) {
    volumeRectangularSolid = length + width + height;
    return volumeRectangularSolid;
  }

  double rectagularSolidSurface(length, width, height) {
    surfaceRectangularSolid =
        2 * (length * width) + 2 * (length * height) + 2 * (width * height);
    return surfaceRectangularSolid;
  }

  double cylinderVolume(r, height) {
    volumeCylinder = 2 * (r * 3.14 * height) + 2 * (3.14 * r * r);
    return volumeCylinder;
  }

  double cylinderSurface(r, height) {
    surfaceCylinder = (r * 3.14 * r) * height;
    return surfaceCylinder;
  }

  double sphereVolume(r) {
    volumeSphere = 1.33333333 * 3.14 * r * r * r;
    return volumeSphere;
  }

  double sphereSurface(r) {
    surfaceCylinder = (r * 3.14 * r) * 4;
    return surfaceCylinder;
  }

  double circleCircumference(r) {
    circumferenceCircle = 2 * 3.14 * r;
    return circumferenceCircle;
  }

  double circleArea(r) {
    areaCircle = r * 3.14 * r;
    return areaCircle;
  }
}
