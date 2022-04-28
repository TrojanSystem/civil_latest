import 'package:example/main_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daily_todos/shop_list/files.dart';
import 'daily_todos/shop_list/shop_model.dart';
import 'daily_todos/todo_list/files.dart';
import 'daily_todos/todo_list/todo_model.dart';
import 'first_thing/attendance/file.dart';
import 'first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'first_thing/store/add_to_store/storage_pdf_report.dart';
import 'first_thing/store/substract_from_store/shop_model_data_for_used_items.dart';
import 'first_thing/store/substract_from_store/storage_pdf_report_for_used_item.dart';
import 'model/calculation.dart';

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
          create: (ctx) => ShopModelDataForStore()..loadShopList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForStorageForUsedItems(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForStorage(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UsedShopModelData()..loadShopList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Shop(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShopHandler(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FileHandlerForAttendance(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TodoHandler(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TodoModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MyCustomSplashScreen(),
        ),
      ),
    );
  }
}
