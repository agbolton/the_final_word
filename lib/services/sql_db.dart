import 'package:sqflite/sqflite.dart';
import '../models/baby_name.dart';
import '../models/baby_db.dart';
import '../models/movie.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DatabaseInstance {
  static const String DATABASE_FILENAME = 'final_word_sqldb.sqlite3.db';
  static const String SQL_INSERT_BOY = 'INSERT INTO boy_names(name) VALUES(?)';
  static const String SQL_INSERT_GIRL =
      'INSERT INTO girl_names(name) VALUES(?)';
  static const String SQL_INSERT_MOVIE = 'INSERT INTO movies(name) VALUES(?)';
  static const String SQL_CREATE_BOYS_SCHEMA =
      'CREATE TABLE IF NOT EXISTS boy_names(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);';
  static const String SQL_CREATE_GIRLS_SCHEMA =
      'CREATE TABLE IF NOT EXISTS girl_names(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);';
  static const String SQL_CREATE_MOVIES_SCHEMA =
      'CREATE TABLE IF NOT EXISTS movies(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);';
  static const String SQL_SELECT_BOYS = 'SELECT * FROM boy_names';
  static const String SQL_SELECT_GIRLS = 'SELECT * FROM girl_names';
  static const String SQL_SELECT_MOVIES = 'SELECT * FROM movies';
  static const GIRL_PATH = 'assets/girl_names_2018.json';
  static const BOY_PATH = 'assets/boy_names_2018.json';
  static const MOVIE_PATH = 'assets/movies.json';

  static DatabaseInstance _instance;

  final Database db;

  DatabaseInstance._({Database database}) : db = database;

  factory DatabaseInstance.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    Names girlNames = Names();
    Names boyNames = Names();
    String girlsJsonString = await rootBundle.loadString(GIRL_PATH);
    String boysJsonString = await rootBundle.loadString(BOY_PATH);
    girlNames = Names.fromJSON(jsonDecode(girlsJsonString));
    boyNames = Names.fromJSON(jsonDecode(boysJsonString));
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, SQL_CREATE_BOYS_SCHEMA);
      createTables(db, SQL_CREATE_GIRLS_SCHEMA);
      createTables(db, SQL_CREATE_MOVIES_SCHEMA);
      var index = 1;
      girlNames.names.forEach((element) {
        BabyName nameToAdd =
            BabyName(id: index, name: element.toString(), gender: 'female');
        saveGirlName(db, name: nameToAdd);
        index++;
      });
      var boysIndex = 1;
      boyNames.names.forEach((element) {
        BabyName nameToAdd =
            BabyName(id: boysIndex, name: element.toString(), gender: 'male');
        saveBoyName(db, name: nameToAdd);
        boysIndex++;
      });
      var movieIndex = 1;
      String moviesJsonString = await rootBundle.loadString(MOVIE_PATH);
      List<dynamic> movies = jsonDecode(moviesJsonString);
      movies.forEach((element) {
        Movie movieToAdd =
            Movie(id: movieIndex, name: element['title'].toString());
        saveMovie(db, movie: movieToAdd);
        movieIndex++;
      });
    });
    _instance = DatabaseInstance._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  static void saveGirlName(Database db, {BabyName name}) async {
    await db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_GIRL, [name.name]);
    });
  }

  static void saveBoyName(Database db, {BabyName name}) async {
    await db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_BOY, [name.name]);
    });
  }

  static void saveMovie(Database db, {Movie movie}) async {
    await db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_MOVIE, [movie.name]);
    });
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

    return BabyName(
        id: babyName[0]['id'], name: babyName[0]['name'], gender: 'male');
  }

  Future<Movie> getNewMovie(int id) async {
    String SQL_MOVIE_SELECT = 'SELECT * FROM movies WHERE id=$id';

    final movieDB = await db.rawQuery(SQL_MOVIE_SELECT);

    return Movie(id: movieDB[0]["id"], name: movieDB[0]["name"]);
  }
}
