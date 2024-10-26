import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE events(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            eventType TEXT,
            date TEXT,
            location TEXT,
            address TEXT,
            email TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertEvent(Map<String, dynamic> event) async {
    final db = await database;
    await db.insert(
      'events',
      event,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    return await db.query('events');
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateEvent(int id, Map<String, dynamic> event) async {
    final db = await database;
    await db.update(
      'events',
      event,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
