import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'shop_model_for_store.dart';

class DatabaseShopStore {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'shopModelDatabaseForStoreTable.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE shopModelDatabaseForStoreTable(id INTEGER PRIMARY KEY, itemName TEXT, storeKeeperName TEXT, itemDate TEXT, itemQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ShopModelForStore task) async {
    Database db = await database();
    int data = await db.insert('shopModelDatabaseForStoreTable', task.toMap());
    return data;
  }

  Future<List<ShopModelForStore>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('shopModelDatabaseForStoreTable');
    List<ShopModelForStore> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => ShopModelForStore.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ShopModelForStore item) async {
    final Database db = await database();
    final rows = await db.update(
      'shopModelDatabaseForStoreTable',
      item.toMap(),
      where: 'itemName = ?',
      whereArgs: [item.itemName],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db.rawDelete(
        "DELETE FROM shopModelDatabaseForStoreTable WHERE itemName = '$id'");
  }
}
