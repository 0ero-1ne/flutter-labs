import 'package:lab7_8/bread.dart';
import 'package:sqflite/sqflite.dart';

class BreadDB {
  static String query = """
  CREATE TABLE IF NOT EXISTS BREADS (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "calories" REAL NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
  )
  """;

  static Future<void> createTable(Database database) async {
    await database.execute(
      query
    );
  }

  static Future<dynamic> create({
    required Database database,
    required String title,
    required double calories
  }) async {
    return await database.rawInsert(
      ''' INSERT INTO BREADS(title, calories) VALUES (?, ?)''',
      [title, calories]
    );
  }

  static Future<List<Bread>> fetchAll(Database database) async {
    final breads = await database.rawQuery(
      ''' SELECT * FROM BREADS '''
    );
    return breads.map((bread) => Bread.fromSqfliteDatabase(bread)).toList();
  }

  static Future<Bread> getBreadById({
    required Database database,
    required int id
  }) async {
    final bread = await database.rawQuery(
      ''' SELECT * FROM BREADS WHERE id = ? ''',
      [id],
    );
    return Bread.fromSqfliteDatabase(bread.first);
  }

  static Future<int> update({
    required Database database,
    required int id,
    required String title,
    required double calories
  }) async {
    return await database.update(
      'BREADS',
      {
        'title': title,
        'calories': calories
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id]
    );
  }

  static Future<void> delete({
    required Database database,
    required int id
  }) async {
    await database.delete(
      'BREADS',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}