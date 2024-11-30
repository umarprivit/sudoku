import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sudoku/Record.dart';

class DatabaseHelper {
  static const int version = 1;
  static const String dbname = "Sudoku.db";

  static Future<Database> getdb() async {
    return openDatabase(join(await getDatabasesPath(), dbname),
        onCreate: ((db, version) async {
      db.execute("CREATE TABLE sudoku (category TEXT,seconds INTEGER);");
    }));
  }

  static Future<int> addRecord(Recordd record) async {
    final db = await getdb();
    return await db.insert("sudoku", record.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // static Future<int> updateRecord(Recordd record) async {
  //   final db = await getdb();
  //   return await db.update("sudoku", record.toJson(),where: "")

  // }

  static Future<List<Recordd>?> getAllRecords() async {
    final db = await getdb();
    final List<Map<String, dynamic>> map = await db.query("sudoku");
    if (map.isEmpty) {
      return null;
    }
    return List.generate(map.length, (index) => Recordd.fromJson(map[index]));
  }
  
}
