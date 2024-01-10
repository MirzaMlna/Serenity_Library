import 'package:sqflite/sqflite.dart' as sql;

class KonghucuEBookSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE konghucuEBooks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      konghucuEBookTitle TEXT,
      konghucuEBookPdf TEXT,
      konghucuEBookCover TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_konghucu_ebook.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createkonghucuEBook(String konghucuEBookTitle,
      String konghucuEBookPdf, String konghucuEBookCover) async {
    final db = await KonghucuEBookSQLHelper.db();
    final data = {
      'konghucuEBookTitle': konghucuEBookTitle,
      'konghucuEBookPdf': konghucuEBookPdf,
      'konghucuEBookCover': konghucuEBookCover,
    };
    final id = await db.insert('konghucuEBooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllkonghucuEBooks() async {
    final db = await KonghucuEBookSQLHelper.db();
    return db.query('konghucuEBooks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSinglekonghucuEBook(
      int id) async {
    final db = await KonghucuEBookSQLHelper.db();
    return db.query('konghucuEBooks',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updatekonghucuEBook(int id, String konghucuEBookTitle,
      String konghucuEBookPdf, String konghucuEBookCover) async {
    final db = await KonghucuEBookSQLHelper.db();
    final data = {
      'konghucuEBookTitle': konghucuEBookTitle,
      'konghucuEBookPdf': konghucuEBookPdf,
      'konghucuEBookCover': konghucuEBookCover,
      'createdAt': DateTime.now().toString(),
    };
    final result = await db
        .update('konghucuEBooks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletekonghucuEBook(int id) async {
    final db = await KonghucuEBookSQLHelper.db();
    try {
      await db.delete('konghucuEBooks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
