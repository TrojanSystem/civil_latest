import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../labour.dart';



const _tableItems = 'attendanceList';

Future<Database> _open() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'attendance.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        '''
          CREATE TABLE $_tableItems( 
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              title TEXT NOT NULL,
              price TEXT NOT NULL,
              phoneNumber TEXT NOT NULL,
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





  Future<int> insert(Labours labour) async {
    final db = await _dbFuture;
    return db.insert(_tableItems, labour.toMap());
  }

  Stream<List<Labours>> getAllItems() async* {
    final db = await _dbFuture;
    yield* db
        .createQuery(_tableItems)
        .mapToList((map) => Labours.fromMap(map));
  }

  Future<bool> update(Labours item) async {
    final db = await _dbFuture;
    final rows = await db.update(
      _tableItems,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<bool> remove(Labours item) async {
    final db = await _dbFuture;
    final rows = await db.delete(
      _tableItems,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return rows > 0;
  }
}
