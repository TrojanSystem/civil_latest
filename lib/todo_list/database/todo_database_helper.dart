import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../todo_model.dart';

const _tableItems = 'todoList';

Future<Database> _open() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'todoList.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        '''
          CREATE TABLE $_tableItems( 
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              todo TEXT NOT NULL,
              date TEXT NOT NULL
              
          )
        ''',
      );
    },
  );
}

class DatabaseHelper {
  static DatabaseHelper _singleton;

  DatabaseHelper._();

  factory DatabaseHelper.getInstance() => _singleton ??= DatabaseHelper._();

  final _dbFuture = _open().then((db) => BriteDatabase(db));

  Future<int> insert(TodoModel todo) async {
    final db = await _dbFuture;
    return db.insert(_tableItems, todo.toMap());
  }

  Stream<List<TodoModel>> getAllItems() async* {
    final db = await _dbFuture;
    yield* db
        .createQuery(_tableItems)
        .mapToList((map) => TodoModel.fromMap(map));
  }

  Future<bool> update(TodoModel todoUpdate) async {
    final db = await _dbFuture;
    final rows = await db.update(
      _tableItems,
      todoUpdate.toMap(),
      where: 'id = ?',
      whereArgs: [todoUpdate.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future delete(int id) async {
    final db = await _dbFuture;

    return db?.delete(
      _tableItems,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
