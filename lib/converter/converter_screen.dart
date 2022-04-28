import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'area_converter.dart';
import 'length_converter.dart';

class ConverterScreen extends StatefulWidget {
  ConverterScreen({Key key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  double convertItem = 0.0;
  int selectedMonth = DateTime.now().month;
  int selectedMonths = 0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final monthSelected =
        Provider.of<ShopModelDataForStore>(context).monthOfAYear;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          title: const Text(
            'Converter',
            style: storageTitle,
          ),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Length'),
              ),
              Tab(
                child: Text('Area'),
              ),
              Tab(child: Text('Weight')),
              Tab(
                child: Text('Volume'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LengthConverter(),
            AreaConverter(),
            LengthConverter(),
            AreaConverter(),
          ],
        ),
      ),
    );
  }
}
