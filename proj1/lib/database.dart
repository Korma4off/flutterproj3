import 'package:path_provider/path_provider.dart';
import 'package:proj1/models/character.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS Characters (id INTEGER, name TEXT, status TEXT, species TEXT, gender TEXT, image TEXT)''');
  }

  Future<List<Character>> getCharacters() async {
    Database db = await instance.database;
    var characters = await db.query('Characters', orderBy: 'id');
    List<Character> charactersList = characters.isNotEmpty ? characters.map((c) => Character.fromMap(c)).toList() : [];
    return charactersList;
  }

  Future<Character> getCharacterFromId(int id) async {
    Database db = await instance.database;
    var character = await db.query('Characters', where: 'id = ?', whereArgs: [id]);
    return Character.fromMap(character[0]);
  }

  Future<int> addCharacter(Character character) async {
    Database db = await instance.database;
    var result = await db.query('Characters', where: 'id = ? ', whereArgs: [character.id]);
    return result.isEmpty ? await db.insert('Characters', character.toMap()) : await db.update('Characters', character.toMap(), where: 'id = ?', whereArgs: [character.id]);
  }

  Future<int> removeCharacter(int id) async {
    Database db = await instance.database;
    return await db.delete('Characters', where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateCharacter(Character character) async {
    Database db = await instance.database;
    return await db.update('Characters', character.toMap(), where: 'id = ?', whereArgs: [character.id]);
  }
/// All other requests
}