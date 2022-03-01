import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database/database_helper.dart';
import 'labour.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({Key key}) : super(key: key);

  @override
  State<AttendanceForm> createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String title = '';
  String price = '';
  String phoneNumber = '';
  DateTime date = DateTime.now();

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().month - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((val) {
      setState(() {
        date = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Valid Name';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                name = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter the title of the labour';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                title = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                final pattern = RegExp("^[0-9]{1,10}");
                if (value.isEmpty) {
                  return 'Enter the price';
                } else if (!pattern.hasMatch(value)) {
                  return 'Enter Valid valid price';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Price/day'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                price = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                final pattern = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
                if (value.isEmpty) {
                  return 'Enter Phone Number';
                } else if (!pattern.hasMatch(value)) {
                  return 'Enter Valid Phone Number';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Phone Number'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                phoneNumber = value;
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: showDate,
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.blue,
                ),
              ),
              Text(
               DateFormat.yMMMEd().format(date),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  int x = await DatabaseHelper.getInstance().insert(
                    Labours(
                      phoneNumber: phoneNumber,
                      date: date.toString(),
                      title: title,
                      name: name,
                      price: price,
                    ),
                  );
                  print( 'this is x $x');
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Contact'),
            ),
          ),
        ],
      ),
    );
  }
}