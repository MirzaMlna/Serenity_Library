import 'package:sqflite/sqflite.dart' as sql;

class IslamEBookSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE islamEBooks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      islamEBookTitle TEXT,
      islamEBookPdf TEXT,
      islamEBookCover TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_islam_ebook.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createIslamEBook(String islamEBookTitle,
      String islamEBookPdf, String islamEBookCover) async {
    final db = await IslamEBookSQLHelper.db();
    final data = {
      'islamEBookTitle': islamEBookTitle,
      'islamEBookPdf': islamEBookPdf,
      'islamEBookCover': islamEBookCover,
    };
    final id = await db.insert('islamEBooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllIslamEBooks() async {
    final db = await IslamEBookSQLHelper.db();
    return db.query('islamEBooks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleIslamEBook(int id) async {
    final db = await IslamEBookSQLHelper.db();
    return db.query('islamEBooks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateIslamEBook(int id, String islamEBookTitle,
      String islamEBookPdf, String islamEBookCover) async {
    final db = await IslamEBookSQLHelper.db();
    final data = {
      'islamEBookTitle': islamEBookTitle,
      'islamEBookPdf': islamEBookPdf,
      'islamEBookCover': islamEBookCover,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('islamEBooks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteIslamEBook(int id) async {
    final db = await IslamEBookSQLHelper.db();
    try {
      await db.delete('islamEBooks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
