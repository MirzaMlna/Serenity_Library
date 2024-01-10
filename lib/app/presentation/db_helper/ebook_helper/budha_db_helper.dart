import 'package:sqflite/sqflite.dart' as sql;

class BudhaEBookSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE budhaEBooks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      budhaEBookTitle TEXT,
      budhaEBookPdf TEXT,
      budhaEBookCover TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_budha_ebook.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createbudhaEBook(String budhaEBookTitle,
      String budhaEBookPdf, String budhaEBookCover) async {
    final db = await BudhaEBookSQLHelper.db();
    final data = {
      'budhaEBookTitle': budhaEBookTitle,
      'budhaEBookPdf': budhaEBookPdf,
      'budhaEBookCover': budhaEBookCover,
    };
    final id = await db.insert('budhaEBooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllbudhaEBooks() async {
    final db = await BudhaEBookSQLHelper.db();
    return db.query('budhaEBooks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSinglebudhaEBook(int id) async {
    final db = await BudhaEBookSQLHelper.db();
    return db.query('budhaEBooks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updatebudhaEBook(int id, String budhaEBookTitle,
      String budhaEBookPdf, String budhaEBookCover) async {
    final db = await BudhaEBookSQLHelper.db();
    final data = {
      'budhaEBookTitle': budhaEBookTitle,
      'budhaEBookPdf': budhaEBookPdf,
      'budhaEBookCover': budhaEBookCover,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('budhaEBooks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletebudhaEBook(int id) async {
    final db = await BudhaEBookSQLHelper.db();
    try {
      await db.delete('budhaEBooks', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
