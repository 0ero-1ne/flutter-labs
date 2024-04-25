import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'bread_db.dart';

class DatabaseService {
  String? _storage;
  Database? _database;

  Future<Database?> get database async {
    return _database;
  }

  Future<String> get fullPath async {
    const name = 'breads.db';
    return join(_storage!, name);
  }

  Future<void> setStorage (String value) async {
    if (value != '') {
      _storage = value;
    }
    _database = await _initialize();
  }

  String get storage {
    return _storage!;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true
    );
    return database;
  }

  Future<void> create(Database database, int version) async => await BreadDB.createTable(database);
}