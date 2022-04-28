import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../shop_model.dart';

const _tableItems = 'shopList';

Future<Database> _open() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'shopList.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        '''
          CREATE TABLE $_tableItems( 
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              quantity TEXT NOT NULL,
              price TEXT NOT NULL,
              total INTEGER NOT NULL,
              date TEXT NOT NULL
          )
        ''',
      );
    },
  );
}

class DatabaseHelperForShop {
  static DatabaseHelperForShop _singleton;

  DatabaseHelperForShop._();

  factory DatabaseHelperForShop.getInstance() =>
      _singleton ??= DatabaseHelperForShop._();

  final _dbFuture = _open().then((db) => BriteDatabase(db));

  Future<int> insert(Shop shop) async {
    final db = await _dbFuture;
    return db.insert(_tableItems, shop.toMap());
  }

  Stream<List<Shop>> getAllItems() async* {
    final db = await _dbFuture;
    yield* db.createQuery(_tableItems).mapToList((map) => Shop.fromMap(map));
  }

  Future<bool> update(Shop item) async {
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

  Future delete(int id) async {
    final db = await _dbFuture;

    return db?.delete(
      _tableItems,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
