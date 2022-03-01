import 'package:example/home_screen.dart';
import 'package:example/model/calculation.dart';
import 'package:example/shop_list/files.dart';
import 'package:example/shop_list/shop_list.dart';
import 'package:example/shop_list/shop_model.dart';
import 'package:example/todo_list/files.dart';
import 'package:example/todo_list/todo_list.dart';
import 'package:example/todo_list/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance/attendanceList.dart';
import 'attendance/file.dart';
import 'bar_calculation/bar_converter.dart';
import 'mix_ratio/mix_ratio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
   // DatabaseHelper.instance.getLabour();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Calculation(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Shop(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShopHandler(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandler(),
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
        home: const Scaffold(
          body: HomeScreen(),
        ),
        routes: {
          AttendanceList.routeName: (ctx) => const AttendanceList(),
          TodoList.routeName: (ctx) => const TodoList(),
          ShopList.routeName: (ctx) => const ShopList(),
          MixRatio.routeName: (ctx) => MixRatio(),
          Bar.routeName: (ctx) => Bar(),
        },
      ),
    );
  }
}
