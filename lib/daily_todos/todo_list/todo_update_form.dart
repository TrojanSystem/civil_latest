import 'package:example/daily_todos/todo_list/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database/todo_database_helper.dart';

class TodoUpdateForm extends StatefulWidget {
  int id = 0;
  String todo = '';
  String date = '';

  TodoUpdateForm({this.id, this.date, this.todo});

  @override
  State<TodoUpdateForm> createState() => _TodoUpdateFormState();
}

class _TodoUpdateFormState extends State<TodoUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String todo = '';
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
              initialValue: widget.todo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Todo';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Todo'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                todo = value;
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
                DateFormat.yMMMEd().format(
                  date,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  bool x = await DatabaseHelper.getInstance().update(
                    TodoModel(
                      id: widget.id,
                      todo: todo,
                      date: DateFormat.yMMMEd().format(date),
                    ),
                  );
                  print(x);
                  Navigator.pop(context);
                }
                setState(() {});
              },
              child: const Text('Update Todo'),
            ),
          )
        ],
      ),
    );
  }
}
