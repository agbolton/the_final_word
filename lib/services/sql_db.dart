import 'package:sqflite/sqflite.dart';
import '../models/baby_name.dart';

class DatabaseInstance {
  static const String DATABASE_FILENAME = 'final_word_sqldb.sqlite3.db';
  static const String SQL_INSERT_BOY = 'INSERT INTO boy_names(name) VALUES(?)';
  static const String SQL_INSERT_GIRL =
      'INSERT INTO girl_names(name) VALUES(?)';
  static const String SQL_CREATE_BOYS_SCHEMA =
      'CREATE TABLE IF NOT EXISTS boy_names(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);';
  static const String SQL_CREATE_GIRLS_SCHEMA =
      'CREATE TABLE IF NOT EXISTS girl_names(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);';
  static const String SQL_SELECT_BOYS = 'SELECT * FROM boy_names';
  static const String SQL_SELECT_GIRLS = 'SELECT * FROM girl_names';

  static DatabaseInstance _instance;

  final Database db;

  DatabaseInstance._({Database database}) : db = database;

  factory DatabaseInstance.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, SQL_CREATE_BOYS_SCHEMA);
      createTables(db, SQL_CREATE_GIRLS_SCHEMA);
    });
    _instance = DatabaseInstance._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveGirlName({BabyName name}) async {
    await db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_GIRL, [name.name]);
    });
  }

  void saveBoyName({BabyName name}) async {
    await db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_BOY, [name.name]);
    });
  }

  void testPrint() async {
    print('Database State is created');
  }

  Future<BabyName> getNewGirlName(int id) async {
    String SQL_BABY_SELECT = 'SELECT * FROM girl_names WHERE id=$id';

    final babyName = await db.rawQuery(SQL_BABY_SELECT);

    return BabyName(
        id: babyName[0]['id'], name: babyName[0]['name'], gender: 'female');
  }

  Future<BabyName> getNewBoyName(int id) async {
    String SQL_BABY_SELECT = 'SELECT * FROM boy_names WHERE id=$id';

    final babyName = await db.rawQuery(SQL_BABY_SELECT);

    print(babyName);

    return BabyName(
        id: babyName[0]['id'], name: babyName[0]['name'], gender: 'male');
  }
}
