import 'dart:async';

import 'package:flutter_demos/sqlite/models/user.dart';
import 'package:flutter_demos/sqlite/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''
    CREATE TABLE $tableUsers (
      id $idType,
      full_name TEXT NOT NULL,
      created_time TEXT NOT NULL
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toMap());

    return id;

    //Tambien se puede utilizar:
    //final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)')
  }

  Future<User> getById(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableUsers,
        columns: userColumns, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID not found');
    }
  }

  Future<List<User>> findAll() async {
    final db = await instance.database;

    final maps = await db.query(tableUsers);

    return maps.map((e) => User.fromJson(e)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(tableUsers, user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableUsers, where: 'id = ?', whereArgs: [id]);
  }
}
