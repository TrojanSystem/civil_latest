import 'package:example/model/calculation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forms.dart';

class Bar extends StatefulWidget {
  static const routeName = '/Bar';

  Bar({Key key}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        elevation: 0,
        title: const Text('No of Bar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Container(
            child: const Forms(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.all(25),
          ),
          Result(),
        ]
            // Column(
            //   children: [
            //
            //   ],
            // ),
            ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cal = Provider.of<Calculation>(context);
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'The number of bar is ${cal.data[0]}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'The number of berga required is ${cal.data[1]}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
