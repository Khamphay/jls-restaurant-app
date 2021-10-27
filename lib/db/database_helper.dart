import 'dart:async';
import 'package:path/path.dart';
import 'package:restaurant_app/model/ordermenu_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper dbInstace = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('helper.db');
    return _database!;
  }

  Future<Database> _initDB(String dbname) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbname);
    return await openDatabase(path,
        version: 2, onCreate: _createTB, onUpgrade: _upgradeTB);
  }

  FutureOr<void> _createTB(Database db, int version) async {
    await db.execute('''CREATE TABLE 
  $tableName(${OrderFields.id} INTEGER PRIMARY KEY, 
  ${OrderFields.menuName} TEXT NOT NULL, 
  ${OrderFields.price} REAL NOT NULL,
  ${OrderFields.qty} INTEGER NOT NULL, 
  ${OrderFields.totalPrice} REAL NOT NULL);
  ''');
  }

  FutureOr<void> _upgradeTB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
          '''ALTER TABLE  $tableName ADD COLUMN ${OrderFields.image} TEXT NULL''');
    }
  }

  Future<OrderMenu?> readOrderById(int id) async {
    final db = await dbInstace.database;
    final order = await db.query(tableName,
        columns: OrderFields.values,
        where: '${OrderFields.id}= ?',
        whereArgs: [id]);

    return order.isNotEmpty ? OrderMenu.fromJson(order.first) : null;
  }

  Future<List<OrderMenu>> readAllOrder() async {
    final db = await dbInstace.database;
    final orders = await db.query(tableName);
    return orders.map((json) => OrderMenu.fromJson(json)).toList();
  }

  Future<OrderMenu> createOrder(OrderMenu order) async {
    final db = await dbInstace.database;
    final id = await db.insert(tableName, order.toJson());
    return order.copy(id: id);
  }

  //Todo: =====OR=====
  // Future<int> createOrder(OrderMenu order) async {
  //   final db = await dbInstace.database;
  //   return await db.insert(tableName, order.toJson());
  // }

  Future<int> updateOrder(OrderMenu order) async {
    final db = await dbInstace.database;
    return db.update(tableName, order.toJson(),
        where: '${OrderFields.id}=?', whereArgs: [order.id]);
  }

  Future<int> delete(int id) async {
    final db = await dbInstace.database;
    return db.delete(tableName, where: '${OrderFields.id}=?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await dbInstace.database;
    return db.delete(tableName);
  }

  Future closeDB() async {
    final db = await dbInstace.database;
    db.close();
  }
}
