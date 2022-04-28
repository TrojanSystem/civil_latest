import 'package:example/first_thing/store/substract_from_store/shop_model_for_used_items.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseShopStoreUsed {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'usedShopModelDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE usedShopModelDatabaseTable(id INTEGER PRIMARY KEY, itemNames TEXT, storeKeeperName TEXT, itemDate TEXT, takeQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(UsedShopModel task) async {
    Database db = await database();
    int data = await db.insert('usedShopModelDatabaseTable', task.toMap());
    return data;
  }

  Future<List<UsedShopModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('usedShopModelDatabaseTable');
    List<UsedShopModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => UsedShopModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(UsedShopModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'usedShopModelDatabaseTable',
      item.toMap(),
      where: 'itemNames = ?',
      whereArgs: [item.itemNames],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db.rawDelete(
        "DELETE FROM usedShopModelDatabaseTable WHERE itemNames = '$id'");
  }
}
