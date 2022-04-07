import 'package:example/model/calculation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MixRatio extends StatefulWidget {
  static const routeName = '/mixratio';

  const MixRatio({Key key}) : super(key: key);

  @override
  State<MixRatio> createState() => _MixRatioState();
}

class _MixRatioState extends State<MixRatio> {
  final formKey = GlobalKey<FormState>();
  String cement = '';
  String sand = '';
  String aggregate = '';
  String water = '';

  @override
  Widget build(BuildContext context) {
    final mixRatio = Provider.of<Calculation>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(106, 27, 154, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(106, 27, 154, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text('Mix Ratio'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Mix-Ratio (C:S:A:W/C)',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty || double.parse(value) < 0) {
                                return 'Error';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            onChanged: (value) {
                              setState(() {
                                cement = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                          width: 60,
                        ),
                        const SizedBox(
                          width: 15,
                          child: Text(
                            ':',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || double.parse(value) < 0) {
                                return 'Error';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            onChanged: (value) {
                              setState(() {
                                sand = value;
                              });
                            },
                          ),
                          width: 60,
                        ),
                        const SizedBox(
                          width: 15,
                          child: Text(
                            ':',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || double.parse(value) < 0) {
                                return 'Error';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            onChanged: (value) {
                              setState(() {
                                aggregate = value;
                              });
                            },
                          ),
                          width: 60,
                        ),
                        const SizedBox(
                          width: 15,
                          child: Text(
                            ':',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || double.parse(value) < 0) {
                                return 'Error';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            onChanged: (value) {
                              setState(() {
                                water = value;
                              });
                            },
                          ),
                          width: 60,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            mixRatio.cement = double.parse(cement);
                            mixRatio.sand = double.parse(sand);
                            mixRatio.aggregate = double.parse(aggregate);
                            mixRatio.water = double.parse(water);
                            mixRatio.addMixRatio(
                              mixRatio.noOfBag(),
                              mixRatio.weightOfSand(),
                              mixRatio.weightOfAggregate(),
                              mixRatio.litreOfWater(),
                            );
                          });
                        }
                      },
                      color: Colors.blue[50],
                      child: const Text(
                        'Calculate',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No of bags ${mixRatio.data[2]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sand in cu.m ${mixRatio.data[3]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Aggregate in cu.m ${mixRatio.data[4]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Water in liter ${mixRatio.data[5]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
