import 'dart:io' show Platform;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  static Database? _database;

  DatabaseManager._internal();

  factory DatabaseManager() {
    return _instance;
  }
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
Future<Database> _initDatabase() async {
 // sur Android/iOS
  if (!Platform.isAndroid && !Platform.isIOS) {
    databaseFactory = databaseFactoryFfi;
  }

  final databasesPath = await getDatabasesPath();
  final dbPath = join(databasesPath, 'redacteurs.db');

  print('DEBUG : Ouverture base de données : $dbPath');

  return await openDatabase(
    dbPath,
    version: 1,
    onCreate: _createDatabase,
  );
}
 
  Future<void> _createDatabase(Database db, int version) async {
    print('DEBUG : Création de la table...');
    await db.execute('''
      CREATE TABLE redacteurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
    print('DEBUG : Table créée!');
  }

  Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await database;
    final maps = await db.query('redacteurs');
    print('DEBUG : Récupération ${maps.length} rédacteurs');
    return List.generate(maps.length, (i) {
      return Redacteur.fromMap(maps[i]);
    });
  }

  Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await database;
    print('DEBUG : Insertion du rédacteur: ${redacteur.nom}');
    final result = await db.insert('redacteurs', redacteur.toMap());
    print('DEBUG : Rédacteur inséré avec ID: $result');
    return result;
  }

  Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await database;
    return await db.update(
      'redacteurs',
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id],
    );
  }

  Future<int> deleteRedacteur(int id) async {
    final db = await database;
    return await db.delete(
      'redacteurs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}