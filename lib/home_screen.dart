import 'dart:async';
import 'package:example/attendance/attendanceList.dart';
import 'package:example/shop_list/shop_list.dart';
import 'package:example/todo_list/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bar_calculation/bar_converter.dart';
import 'category_item.dart';
import 'mix_ratio/mix_ratio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String time = "";
  String day = "";

  @override
  void initState() {

    Timer mytimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime timenow = DateTime.now(); //get current date and time
      time = timenow.hour.toString() +
          ":" +
          timenow.minute.toString() +
          ":" +
          timenow.second.toString();
      //  day = timenow.day.toString() + "/" + timenow.month.toString() + "/" + timenow.year.toString();
      //day =DateFormat.yMMMMEEEEd().format(timenow);
      day = DateFormat.yMEd().add_jms().format(DateTime.now());

      setState(() {});
      //mytimer.cancel() //to terminate this timer
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(106, 27, 154, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(106, 27, 154, 1),
          elevation: 0,
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 40,
              ),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: day,
                    style: const TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          color: const Color.fromRGBO(106, 27, 154, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              children: [
                CategoryItem(
                  color: Colors.green,
                  title: 'Mix Ratio',
                  image: 'images/2.jpg',
                  navigate: () {
                    Navigator.of(context).pushNamed(MixRatio.routeName);
                  },
                ),
                CategoryItem(
                  color: Colors.limeAccent,
                  title: 'Bar Schedule',
                  image: 'images/1.jpg',
                  navigate: () {
                    Navigator.of(context).pushNamed(Bar.routeName);
                  },
                ),
                CategoryItem(
                  color: Colors.teal,
                  title: 'Attendance',
                  image: 'images/3.png',
                  navigate: () {
                    Navigator.of(context).pushNamed(AttendanceList.routeName);
                  },
                ),
                CategoryItem(
                  color: Colors.lightBlue,
                  title: 'To Do List',
                  image: 'images/4.png',
                  navigate: () {
                    Navigator.of(context).pushNamed(TodoList.routeName);
                  },
                ),
                CategoryItem(
                  color: Colors.grey,
                  title: 'Shopping List',
                  image: 'images/5.png',
                  navigate: () {
                    Navigator.of(context).pushNamed(ShopList.routeName);
                  },
                ),
                CategoryItem(
                  color: Colors.pink,
                  title: 'Converter',
                  image: 'images/6.jpg',
                  navigate: () {
                    //  Navigator.of(context).pushNamed(ConverterScreen.routeName);
                  },
                ),
              ],
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
