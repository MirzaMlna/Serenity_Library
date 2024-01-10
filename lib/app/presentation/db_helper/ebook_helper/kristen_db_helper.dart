import 'package:sqflite/sqflite.dart' as sql;

class KristenEBookSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE kristenEBooks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      kristenEBookTitle TEXT,
      kristenEBookPdf TEXT,
      kristenEBookCover TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_kristen_ebook.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createkristenEBook(String kristenEBookTitle,
      String kristenEBookPdf, String kristenEBookCover) async {
    final db = await KristenEBookSQLHelper.db();
    final data = {
      'kristenEBookTitle': kristenEBookTitle,
      'kristenEBookPdf': kristenEBookPdf,
      'kristenEBookCover': kristenEBookCover,
    };
    final id = await db.insert('kristenEBooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllkristenEBooks() async {
    final db = await KristenEBookSQLHelper.db();
    return db.query('kristenEBooks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSinglekristenEBook(
      int id) async {
    final db = await KristenEBookSQLHelper.db();
    return db.query('kristenEBooks',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updatekristenEBook(int id, String kristenEBookTitle,
      String kristenEBookPdf, String kristenEBookCover) async {
    final db = await KristenEBookSQLHelper.db();
    final data = {
      'kristenEBookTitle': kristenEBookTitle,
      'kristenEBookPdf': kristenEBookPdf,
      'kristenEBookCover': kristenEBookCover,
      'createdAt': DateTime.now().toString(),
    };
    final result = await db
        .update('kristenEBooks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletekristenEBook(int id) async {
    final db = await KristenEBookSQLHelper.db();
    try {
      await db.delete('kristenEBooks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
