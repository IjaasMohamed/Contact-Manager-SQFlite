import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SQLHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await SQLHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SQLHelper.database();
    return db.query(table);
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await SQLHelper.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  static Future<void> delete(String table, int id) async {
    final db = await SQLHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
