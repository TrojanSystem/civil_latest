import 'dart:async';

import 'package:example/converter/converter_data_calculation.dart';
import 'package:example/daily_todos/shop_list/shop_model.dart';
import 'package:example/daily_todos/todo_list/files.dart';
import 'package:example/daily_todos/todo_list/todo_model.dart';
import 'package:example/model/calculation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../First_Thing/attendance/file.dart';
import '../daily_todos/shop_list/daily_shop_data.dart';
import '../first_thing/attendance/daily_attendance_data.dart';
import '../first_thing/store/add_to_store/shop_model_data_for_store.dart';
import '../first_thing/store/add_to_store/storage_pdf_report.dart';
import '../first_thing/store/substract_from_store/shop_model_data_for_used_items.dart';
import '../first_thing/store/substract_from_store/storage_pdf_report_for_used_item.dart';
import 'menu_list_item.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Calculation(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShopModelDataForStore()..loadShopList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForStorageForUsedItems(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForStorage(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ConverterDataCalculation(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UsedShopModelData()..loadShopList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Shop(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DailyShopData()..loadDailyShopList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForAttendance(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DailyAttendanceData()..loadDailyAttendanceList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TodoHandler(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TodoModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
            elevation: 0,
            title: Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
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
                  textAlign: TextAlign.center,
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
          body: const MyCustomWidget(),
        ),
      ),
    );
  }
}
