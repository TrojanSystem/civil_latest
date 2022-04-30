import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../constants.dart';
import 'input_form/rectangle_input.dart';

class VolumeAndAreaScreen extends StatefulWidget {
  @override
  _VolumeAndAreaScreenState createState() => _VolumeAndAreaScreenState();
}

class _VolumeAndAreaScreenState extends State<VolumeAndAreaScreen> {
  @override
  Widget build(BuildContext c) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    List geometricShape = [
      {'shape': 'Rectangle', 'img': 'Rectangle.jpg'},
      {'shape': 'Parallelogram', 'img': 'parallelogram.jpg'},
      {'shape': 'Triangle', 'img': 'triangle.jpg'},
      {'shape': 'Trapezoid', 'img': 'trapezoid.jpg'},
      {'shape': 'Circle', 'img': 'circle.jpg'},
      {'shape': 'Rectangular Solid', 'img': 'rectangular solid.jpg'},
      {'shape': 'Prisms', 'img': 'prisms.jpg'},
      {'shape': 'Cylinder', 'img': 'cylinder.jpg'},
      {'shape': 'Pyramid', 'img': 'pyramid.jpg'},
      {'shape': 'Cones', 'img': 'cones.jpg'},
      {'shape': 'Sphere', 'img': 'sphere.jpg'},
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Volume & Area',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: AnimationLimiter(
        child: GridView.count(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 60),
          crossAxisCount: columnCount,
          children: List.generate(
            11,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: columnCount,
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) {
                            switch (index) {
                              case 0:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Length',
                                  inputTwo: 'Width',
                                );
                                break;
                              case 1:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Base',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 2:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Base',
                                  inputTwo: 'Height',
                                  inputThree: 'C',
                                );
                                break;
                              case 3:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'h',
                                  inputTwo: 'b2',
                                  inputThree: 'C',
                                  inputFour: 'b1',
                                );
                                break;
                              case 4:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Radius',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 5:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Length',
                                  inputTwo: 'Height',
                                  inputThree: 'Width',
                                );
                                break;
                              case 6:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Base',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 7:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Radius',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 8:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Base',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 9:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Radius',
                                  inputThree: 'Base',
                                  inputTwo: 'Height',
                                );
                                break;
                              case 10:
                                return RectangleInput(
                                  title: geometricShape[index]['shape'],
                                  image: geometricShape[index]['img'],
                                  inputOne: 'Radius',
                                  inputTwo: 'Height',
                                );
                                break;
                              default:
                                return const Center(child: Text(''));
                            }
                          }),
                        );
                        //Text(geometricShape[index])
                      },
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                image: AssetImage(
                                    'images/${geometricShape[index]['img']}'),
                              ),
                              Text(geometricShape[index]['shape'])
                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(
                            bottom: _w / 30, left: _w / 60, right: _w / 60),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
