import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  bool checked=false;
  int id;
  String todo;
  String date;

  TodoModel({
    this.id,
    this.todo,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'date': date,

      // 'checked': checked
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      todo: map['todo'],
      date: map['date'],

      // checked: map['checked'],
    );
  }
}
