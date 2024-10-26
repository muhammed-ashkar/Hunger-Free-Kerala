import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE events(id INTEGER PRIMARY KEY, venue TEXT, date TEXT, time TEXT, address TEXT, location TEXT, phone TEXT, category TEXT)",
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

  Future<List<Map<String, dynamic>>> getSavedEvents() async {
    final db = await database;
    return await db.query('events'); // Assuming saved events are stored in the same table
  }
}
