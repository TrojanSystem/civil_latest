
import 'package:example/model/calculation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forms extends StatefulWidget {
  const Forms({Key key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    final result = Provider.of<Calculation>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    double length = 0;
    double cl = 0;
    double cc = 0;

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Length',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || (double.parse(value) < 0)) {
                        return 'Enter valid Number';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      length = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter the length',
                      hintStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        // letterSpacing: 1.5,
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'CL',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || (double.parse(value) < 0)) {
                        return 'Enter valid Number';
                      }
                    },
                    onChanged: (value) {
                      cl = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter the Cutting Length',
                      hintStyle: TextStyle(
                        color: Colors.blue[900],
                        //fontSize: 18,
                        // letterSpacing: 1.5,
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'C/C',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || (double.parse(value) < 0)) {
                        return 'Enter valid Number';
                      }
                    },
                    onChanged: (value) {
                      cc = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Center to Center ',
                      hintStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        //letterSpacing: 1.5,
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  setState(() {
                    result.length = length;
                    result.cc = cc;
                    result.cl = cl;
                    result.addAnswer(result.noOfBar(),result.noOfBerga());
                    // result.data[1] = result.noOfBerga().toString();
                  });
                  print('list ${result.data[0]}');
                  print(
                      'Tot No of Bar ${Provider.of<Calculation>(context, listen: false).noOfBar()}');
                  print(
                      'Tot No Of Berga ${Provider.of<Calculation>(context, listen: false).noOfBerga()}');
                  print('Button Pressed');
                  const snackbar = SnackBar(
                    duration: Duration(seconds: 1),
                    dismissDirection: DismissDirection.down,
                    content: Text(
                      'Submitting',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              },
              color: Colors.blue[50],
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
