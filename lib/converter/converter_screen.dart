import 'package:example/converter/volume_converter.dart';
import 'package:example/converter/weight_converter.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'area_converter.dart';
import 'length_converter.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key key}) : super(key: key);

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
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.blue[300].withOpacity(0.4),
              border:  Border(
                bottom: BorderSide(color: Colors.white, width: 3),
              ),
            ),
            tabs: const [
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
            WeightConverter(),
            VolumeConverter(),
          ],
        ),
      ),
    );
  }
}
