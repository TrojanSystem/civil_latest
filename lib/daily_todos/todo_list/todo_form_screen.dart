import 'package:example/daily_todos/todo_list/todo_form.dart';
import 'package:flutter/material.dart';

class TodoFormScreen extends StatelessWidget {
  const TodoFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Todo'),
      ),
      body: TodoForm(),
    );
  }
}
