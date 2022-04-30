import 'dart:math';

import 'package:example/daily_todos/todo_list/todo_form.dart';
import 'package:example/daily_todos/todo_list/todo_model.dart';
import 'package:example/daily_todos/todo_list/todo_update_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../drop_down_menu_button_for_daily_todos.dart';
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
      // backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Daily Task',
          style: storageTitle,
        ),
        elevation: 0,
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
          return items.isNotEmpty
              ? Container(
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(red, green, blue, 1)
                                .withOpacity(0.7),
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
                                Provider.of<TodoModel>(context, listen: false)
                                        .checked
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
                                    date: items[index].date,
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
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Are you sure'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        },
                                        child: const Text('No'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          DatabaseHelper.getInstance()
                                              .delete(items[index].id);
                                          Navigator.of(ctx).pop(true);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                    content: const Text(
                                        'Do you want to remove the Todos?'),
                                  ),
                                );
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
                )
              : const Center(
                  child: Text(
                    'Daily Task is Empty!',
                    style: storageTitle,
                  ),
                );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButtonForDailyTodos(
          primaryColor: const Color.fromRGBO(3, 83, 151, 1),
          iconsOne: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          iconsTwo: const Image(
            image: AssetImage('images/pdf.png'),
            width: 40,
          ),
          iconsThree: const Icon(Icons.arrow_back_ios),
          button_11: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => const TodoForm(),
            );
          },
          button_22: () {
            setState(() {
              Provider.of<TodoHandler>(context, listen: false).createTable();
            });
          },
          button_33: () {
            Navigator.of(context).pop();
          },
          button_44: () {},
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
      //   onPressed: () {
      //
      //   },
      //   child: const Icon(
      //     Icons.add,
      //   ),
      // ),
    );
  }
}
