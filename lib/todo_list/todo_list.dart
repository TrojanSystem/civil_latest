import 'dart:math';
import 'package:example/todo_list/todo_form.dart';
import 'package:example/todo_list/todo_model.dart';
import 'package:example/todo_list/todo_update_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'database/todo_database_helper.dart';
import 'files.dart';

class TodoList extends StatefulWidget {
  static const routeName = '/TodoList';

  const TodoList({Key key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int red = 0;
  int green = 0;
  int blue = 0;
  int id = 0;

  @override
  void initState() {
    DatabaseHelper.getInstance().getAllItems();
    var rng = Random();
    red = rng.nextInt(251);
    green = rng.nextInt(251);
    blue = rng.nextInt(251);
    print('red: $red green: $green blue: $blue');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<TodoHandler>(context, listen: false).createTable();
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
        backgroundColor: Color.fromRGBO(red, green, blue, 1),
        title: const Text('Task List'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<TodoModel>>(
        stream: DatabaseHelper.getInstance().getAllItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          final items = snapshot.data;
          final newLabour = snapshot.data
              .map((e) => TodosModel(
                    date: e.date,
                    todo: e.todo,
                  ))
              .toList();
          Provider.of<TodoHandler>(context, listen: false).fileList = newLabour;
          return Container(
            height: double.infinity,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
                      const Color.fromRGBO(76, 175, 80, 1),
                    ],
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 25),
                  title: Text(
                    items[index].todo,
                    style: TextStyle(
                      fontSize: 20,
                      decoration:
                          Provider.of<TodoModel>(context, listen: false).checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    items[index].date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => TodoUpdateForm(
                              id: items[index].id,
                              todo: items[index].todo,
                              date:items[index].date,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          DatabaseHelper.getInstance().delete(items[index].id);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 30,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => TodoForm(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
