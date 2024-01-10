import 'package:sqflite/sqflite.dart' as sql;

class ReportSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      reportId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      reportTitle TEXT,
      reportDesc TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_report.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

//create data
  static Future<int> createData(String reportTitle, String reportDesc) async {
    final db = await ReportSQLHelper.db();
    final data = {
      'reportTitle': reportTitle,
      'reportDesc': reportDesc,
    };
    final reportId = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return reportId;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await ReportSQLHelper.db();
    return db.query('data', orderBy: 'reportId');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int reportId) async {
    final db = await ReportSQLHelper.db();
    return db.query('data',
        where: "reportId = ?", whereArgs: [reportId], limit: 1);
  }

//update data
  static Future<int> updateData(
      int reportId, String reportTitle, String reportDesc) async {
    final db = await ReportSQLHelper.db();
    final data = {
      'reportTitle': reportTitle,
      'reportDesc': reportDesc,
      'createdAt': DateTime.now().toString()
    };
    final result = await db
        .update('data', data, where: "reportId = ?", whereArgs: [reportId]);
    return result;
  }

//delete data
  static Future<void> deleteData(int reportId) async {
    final db = await ReportSQLHelper.db();
    try {
      await db.delete('data', where: "reportId = ?", whereArgs: [reportId]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
