import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../shop_model.dart';

class DatabaseForDailyShop {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dailyShopTable.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE dailyShopTable( id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              quantity TEXT NOT NULL,
              price TEXT NOT NULL,
              total INTEGER NOT NULL,
              date TEXT NOT NULL)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(Shop task) async {
    Database db = await database();
    int data = await db.insert('dailyShopTable', task.toMap());
    return data;
  }

  Future<List<Shop>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('dailyShopTable');
    List<Shop> tasksList =
        tasks.isNotEmpty ? tasks.map((e) => Shop.fromMap(e)).toList() : [];
    return tasksList;
  }

  Future<bool> updateTaskList(Shop item) async {
    final Database db = await database();
    final rows = await db.update(
      'dailyShopTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.name],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM dailyShopTable WHERE id = '$id'");
  }
}
