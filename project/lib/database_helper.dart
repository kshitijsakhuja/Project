import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'zoopE.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        phone_number TEXT UNIQUE,
        password TEXT,
        is_verified INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE search_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        query TEXT,
        distance REAL,
        timestamp TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE rentals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        bike_id TEXT,
        start_time TEXT,
        end_time TEXT,
        start_location TEXT,
        end_location TEXT,
        distance REAL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
  }

  // Add method to insert a user
  Future<int> insertUser(String name, String email, String phoneNumber, String password) async {
    final db = await database;
    return await db.insert('users', {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    });
  }

  // Add method to insert search history
  Future<int> insertSearchHistory(int userId, String query, double distance) async {
    final db = await database;
    return await db.insert('search_history', {
      'user_id': userId,
      'query': query,
      'distance': distance,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Add method to insert rental details
  Future<int> insertRental(int userId, String bikeId, String startTime, String endTime, String startLocation, String endLocation, double distance) async {
    final db = await database;
    return await db.insert('rentals', {
      'user_id': userId,
      'bike_id': bikeId,
      'start_time': startTime,
      'end_time': endTime,
      'start_location': startLocation,
      'end_location': endLocation,
      'distance': distance,
    });
  }

  // Method to query user by email or phone number
  Future<Map<String, dynamic>?> queryUserByEmailOrPhone(String identifier) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('users',
        where: 'email = ? OR phone_number = ?', whereArgs: [identifier, identifier]);
    return result.isNotEmpty ? result.first : null;
  }
}
