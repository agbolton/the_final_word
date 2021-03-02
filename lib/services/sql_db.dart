import 'package:sqflite/sqflite.dart';
import '../models/baby_name.dart';

class DatabaseInstance {

  static const String DATABASE_FILENAME = 'the_final_word.sqlite3.db';
  static const String SQL_INSERT = 'INSERT INTO baby_names(name, gender) VALUES(?, ?)';
  static const String SQL_CREATE_SCHEMA = 'CREATE TABLE IF NOT EXISTS baby_names(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, gender TEXT NOT NULL);';
  static const String SQL_SELECT = 'SELECT * FROM baby_names';

  static DatabaseInstance _instance;

  final Database db;

  DatabaseInstance._({Database database}) : db = database;

  factory DatabaseInstance.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {

    final db = await openDatabase(DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, SQL_CREATE_SCHEMA);
      }
    );

    _instance = DatabaseInstance._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveBabyName({BabyName name}) async {
    await db.transaction( (txn) async {
      await txn.rawInsert(SQL_INSERT, [name.name, name.gender]);
    });
  }

  Future<List<BabyName>> allBabyNames() async {
    final allBabyNames = await db.rawQuery(SQL_SELECT);

    final babyNameEntries = allBabyNames.map( (record) {
      return BabyName(
        id: record['id'].toString(),
        name: record['name'],
        gender: record['gender']
      );
    }).toList();
    
    return babyNameEntries;
  }

  Future<BabyName> getNewName(int id) async {
    String SQL_BABY_SELECT = 'SELECT * FROM baby_names WHERE id=$id';

    final babyName = await db.rawQuery(SQL_BABY_SELECT);

    return BabyName(
      id: babyName[0]['id'].toString(),
      name: babyName[0]['name'],
      gender: babyName[0]['gender']
    );
  }

}