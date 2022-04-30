import 'package:example/converter/converter_screen.dart';
import 'package:example/volume_and_area/volume_and_area_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../daily_todos/daily_todos_screen.dart';
import '../first_thing/first_thing_screen.dart';
import '../mix_ratio/mix_ratio.dart';
import '../model/category_item.dart';
import '../rebar_calculation/bar_calculation/bar_converter.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({Key key}) : super(key: key);

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext c) {
    List<Widget> menuBar = [
      CategoryItem(
        color: Colors.green,
        title: 'Concrete',
        image: 'images/2.jpg',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MixRatio(),
            ),
          );
        },
      ),
      CategoryItem(
        color: Colors.limeAccent,
        title: 'Bar Schedule',
        image: 'images/1.jpg',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Bar(),
            ),
          );
        },
      ),
      CategoryItem(
        color: Colors.teal,
        title: 'Volume & Area',
        image: 'images/sphere.jpg',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => VolumeAndAreaScreen(),
            ),
          );
        },
      ),
      CategoryItem(
        color: Colors.lightBlue,
        title: 'First Thing',
        image: 'images/3.png',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FirstThingScreen(),
            ),
          );
        },
      ),
      CategoryItem(
        color: Colors.grey,
        title: 'Daily Todos',
        image: 'images/4.png',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DailyTodosScreen(),
            ),
          );
        },
      ),
      CategoryItem(
        color: Colors.pink,
        title: 'Converter',
        image: 'images/6.jpg',
        navigate: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ConverterScreen(),
            ),
          );
        },
      ),
    ];
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      body: AnimationLimiter(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.fromLTRB(_w / 60, _w / 10, _w / 60, _w / 60),
          crossAxisCount: columnCount,
          children: List.generate(
            6,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: columnCount,
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: Container(
                      child: menuBar[index],
                      margin: EdgeInsets.only(
                          bottom: _w / 15, left: _w / 60, right: _w / 60),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
