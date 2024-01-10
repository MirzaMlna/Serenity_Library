import 'package:sqflite/sqflite.dart' as sql;

class HinduEBookSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE hinduEBooks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      hinduEBookTitle TEXT,
      hinduEBookPdf TEXT,
      hinduEBookCover TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_hindu_ebook.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createhinduEBook(String hinduEBookTitle,
      String hinduEBookPdf, String hinduEBookCover) async {
    final db = await HinduEBookSQLHelper.db();
    final data = {
      'hinduEBookTitle': hinduEBookTitle,
      'hinduEBookPdf': hinduEBookPdf,
      'hinduEBookCover': hinduEBookCover,
    };
    final id = await db.insert('hinduEBooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllhinduEBooks() async {
    final db = await HinduEBookSQLHelper.db();
    return db.query('hinduEBooks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSinglehinduEBook(int id) async {
    final db = await HinduEBookSQLHelper.db();
    return db.query('hinduEBooks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updatehinduEBook(int id, String hinduEBookTitle,
      String hinduEBookPdf, String hinduEBookCover) async {
    final db = await HinduEBookSQLHelper.db();
    final data = {
      'hinduEBookTitle': hinduEBookTitle,
      'hinduEBookPdf': hinduEBookPdf,
      'hinduEBookCover': hinduEBookCover,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('hinduEBooks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletehinduEBook(int id) async {
    final db = await HinduEBookSQLHelper.db();
    try {
      await db.delete('hinduEBooks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
