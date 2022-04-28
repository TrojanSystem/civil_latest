import 'package:flutter/material.dart';

import 'attendance_input_form.dart';

class AttendanceFormScreen extends StatelessWidget {
  const AttendanceFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Labour'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AttendanceForm(),
      ),
    );
  }
}
