import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../labour.dart';

class DatabaseForDailyAttendance {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dailyAttendanceTable.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE dailyAttendanceTable( id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              title TEXT NOT NULL,
              price TEXT NOT NULL,
              phoneNumber TEXT NOT NULL,
              date TEXT NOT NULL)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(LaboursAttendance task) async {
    Database db = await database();
    int data = await db.insert('dailyAttendanceTable', task.toMap());
    return data;
  }

  Future<List<LaboursAttendance>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('dailyAttendanceTable');
    List<LaboursAttendance> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => LaboursAttendance.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(LaboursAttendance item) async {
    final Database db = await database();
    final rows = await db.update(
      'dailyAttendanceTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM dailyAttendanceTable WHERE id = '$id'");
  }
}
