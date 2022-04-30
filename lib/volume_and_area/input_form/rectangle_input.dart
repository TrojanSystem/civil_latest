import 'package:example/volume_and_area/calculator_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

final formKeys = GlobalKey<FormState>();

class RectangleInput extends StatefulWidget {
  final String title;
  final String image;
  final String inputOne;
  final String inputTwo;
  final String inputThree;
  final String inputFour;

  RectangleInput(
      {Key key,
      this.title,
      this.image,
      this.inputOne,
      this.inputTwo,
      this.inputFour,
      this.inputThree})
      : super(key: key);

  @override
  State<RectangleInput> createState() => _RectangleInputState();
}

class _RectangleInputState extends State<RectangleInput> {
  double formOne = 0.0;

  double formTwo = 0.0;
  double formThree = 0.0;

  double formFour = 0.0;

  @override
  Widget build(BuildContext context) {
    final calculate = Provider.of<CalculatorClass>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: Text(
          widget.title,
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: Form(
        key: formKeys,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.inputOne,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '${widget.inputOne} can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                formOne = double.parse(value);
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Text('m'),
                                ),
                                hintText: '${widget.inputOne}',
                                filled: true,
                                fillColor: Colors.grey[200],
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.title == 'Parallelogram' ||
                              widget.title == 'Triangle' ||
                              widget.title == 'Rectangular Solid' ||
                              widget.title == 'Prisms' ||
                              widget.title == 'Cones' ||
                              widget.title == 'Trapezoid' ||
                              widget.title == 'Cylinder' ||
                              widget.title == 'Rectangle' ||
                              widget.title == 'Pyramid'
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputTwo,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '${widget.inputTwo} can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      formTwo = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(top: 18.0),
                                        child: Text('m'),
                                      ),
                                      hintText: widget.inputTwo,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(''),
                      widget.title == 'Triangle' ||
                              widget.title == 'Rectangular Solid' ||
                              widget.title == 'Cones' ||
                              widget.title == 'Trapezoid'
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputThree,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '${widget.inputThree} can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      formThree = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(top: 18.0),
                                        child: Text('m'),
                                      ),
                                      hintText: widget.inputThree,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(''),
                      widget.title == 'Trapezoid'
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputFour,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '${widget.inputFour} can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      formFour = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(top: 18.0),
                                        child: Text('m'),
                                      ),
                                      hintText: widget.inputFour,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(''),
                      GestureDetector(
                        onTap: () {
                          if (formKeys.currentState.validate()) {
                            formKeys.currentState.save();

                            setState(() {
                              if (widget.title == 'Circle' ||
                                  widget.title == 'Sphere') {
                                calculate.sphereVolume(formOne);
                                calculate.sphereSurface(formOne);
                                calculate.circleArea(formOne);
                                calculate.circleCircumference(formOne);
                              } else if (widget.title == 'Rectangle' ||
                                  widget.title == 'Parallelogram' ||
                                  widget.title == 'Prisms' ||
                                  widget.title == 'Cylinder' ||
                                  widget.title == 'Pyramid') {
                                calculate.rectangleArea(formOne, formTwo);
                                calculate.rectanglePerimeter(formOne, formTwo);
                                calculate.parallelogramArea(formOne, formTwo);
                                calculate.parallelogramPerimeter(
                                    formOne, formTwo);
                                calculate.prismsVolume(formOne, formTwo);
                                calculate.cylinderSurface(formOne, formTwo);
                                calculate.cylinderVolume(formOne, formTwo);
                                calculate.prismsVolume(formOne, formTwo);
                              } else if (widget.title == 'Rectangular Solid' ||
                                  widget.title == 'Triangle' ||
                                  widget.title == 'Cones') {
                                calculate.rectagularSolidVolume(
                                    formOne, formTwo, formThree);
                                calculate.rectagularSolidSurface(
                                    formOne, formTwo, formThree);
                                calculate.triangleArea(
                                    formOne, formTwo, formThree);
                                calculate.trianglePerimeter(
                                    formOne, formTwo, formThree);
                                calculate.coneVolume(
                                    formOne, formTwo, formThree);
                              } else if (widget.title == 'Trapezoid') {
                                calculate.trapezoidPerimeter(
                                    formOne, formTwo, formThree, formFour);
                                calculate.trapezoidArea(
                                    formOne, formTwo, formThree, formFour);
                              } else {
                                calculate.rectangleArea(formOne, formTwo);
                                calculate.rectanglePerimeter(formOne, formTwo);
                              }
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Calculate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Image(
                      image: AssetImage('images/${widget.image}'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.title == 'Rectangle'
                      ? Column(
                          children: [
                            Text(
                              'Area: ${calculate.rectangleArea(formOne, formTwo).toStringAsFixed(2)}',
                              style: storageTitle,
                            ),
                            Text(
                              'Perimeter : ${calculate.rectanglePerimeter(formOne, formTwo).toStringAsFixed(2)}',
                              style: storageTitle,
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        )
                      : widget.title == 'Parallelogram'
                          ? Column(
                              children: [
                                Text(
                                  'Area: ${calculate.rectangleArea(formOne, formTwo).toStringAsFixed(2)}',
                                  style: storageTitle,
                                ),
                                Text(
                                  'Perimeter : ${calculate.rectanglePerimeter(formOne, formTwo).toStringAsFixed(2)}',
                                  style: storageTitle,
                                ),
                              ],
                              mainAxisSize: MainAxisSize.min,
                            )
                          : widget.title == 'Triangle'
                              ? Column(
                                  children: [
                                    Text(
                                      'Area: ${calculate.triangleArea(formOne, formTwo, formThree).toStringAsFixed(2)}',
                                      style: storageTitle,
                                    ),
                                    Text(
                                      'Perimeter : ${calculate.trianglePerimeter(formOne, formTwo, formThree).toStringAsFixed(2)}',
                                      style: storageTitle,
                                    ),
                                  ],
                                  mainAxisSize: MainAxisSize.min,
                                )
                              : widget.title == 'Trapezoid'
                                  ? Column(
                                      children: [
                                        Text(
                                          'Area: ${calculate.trapezoidArea(formOne, formTwo, formThree, formFour).toStringAsFixed(2)}',
                                          style: storageTitle,
                                        ),
                                        Text(
                                          'Perimeter : ${calculate.trapezoidPerimeter(formOne, formTwo, formThree, formFour).toStringAsFixed(2)}',
                                          style: storageTitle,
                                        ),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    )
                                  : widget.title == 'Circle'
                                      ? Column(
                                          children: [
                                            Text(
                                              'Area: ${calculate.circleArea(formOne).toStringAsFixed(2)}',
                                              style: storageTitle,
                                            ),
                                            Text(
                                              'Circumference : ${calculate.circleCircumference(formOne).toStringAsFixed(2)}',
                                              style: storageTitle,
                                            ),
                                          ],
                                          mainAxisSize: MainAxisSize.min,
                                        )
                                      : widget.title == 'Rectangular Solid'
                                          ? Column(
                                              children: [
                                                Text(
                                                  'Volume: ${calculate.rectagularSolidVolume(formOne, formTwo, formThree).toStringAsFixed(2)}',
                                                  style: storageTitle,
                                                ),
                                                Text(
                                                  'Surface : ${calculate.rectagularSolidSurface(formOne, formTwo, formThree).toStringAsFixed(2)}',
                                                  style: storageTitle,
                                                ),
                                              ],
                                              mainAxisSize: MainAxisSize.min,
                                            )
                                          : widget.title == 'Prisms'
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      'Volume: ${calculate.prismsVolume(formOne, formTwo).toStringAsFixed(2)}',
                                                      style: storageTitle,
                                                    ),
                                                  ],
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                )
                                              : widget.title == 'Cylinder'
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          'Volume: ${calculate.cylinderVolume(formOne, formTwo).toStringAsFixed(2)}',
                                                          style: storageTitle,
                                                        ),
                                                        Text(
                                                          'Surface : ${calculate.cylinderSurface(formOne, formTwo).toStringAsFixed(2)}',
                                                          style: storageTitle,
                                                        ),
                                                      ],
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                    )
                                                  : widget.title == 'Pyramid'
                                                      ? Column(
                                                          children: [
                                                            Text(
                                                              'Volume: ${calculate.prismsVolume(formOne, formTwo).toStringAsFixed(2)}',
                                                              style:
                                                                  storageTitle,
                                                            ),
                                                          ],
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                        )
                                                      : widget.title == 'Cones'
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                  'Volume: ${calculate.coneVolume(formOne, formTwo, formThree).toStringAsFixed(2)}',
                                                                  style:
                                                                      storageTitle,
                                                                ),
                                                              ],
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                            )
                                                          : widget.title ==
                                                                  'Sphere'
                                                              ? Column(
                                                                  children: [
                                                                    Text(
                                                                      'Volume: ${calculate.sphereVolume(formOne).toStringAsFixed(2)}',
                                                                      style:
                                                                          storageTitle,
                                                                    ),
                                                                    Text(
                                                                      'Surface : ${calculate.sphereSurface(formOne).toStringAsFixed(2)}',
                                                                      style:
                                                                          storageTitle,
                                                                    ),
                                                                  ],
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                )
                                                              : const Text(
                                                                  'Unknown Calculation',
                                                                  style:
                                                                      storageTitle,
                                                                )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
