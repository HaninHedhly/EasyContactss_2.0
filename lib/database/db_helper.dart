import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  // Internal: return the opened database (create if needed)
  static Future<Database> _openDB() async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    // 🔥 Print the database full path (useful for debugging)
    print('DB path: $path');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL,
            email TEXT NOT NULL
          )
        ''');
      },
    );

    return _db!;
  }

  /// STATIC HELPERS — DBHelper.insertContact(...)
  static Future<int> insertContact(String name, String phone, String email) async {
    final db = await _openDB();
    return await db.insert('contacts', {
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  static Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await _openDB();
    return await db.query('contacts', orderBy: 'name COLLATE NOCASE');
  }

  static Future<int> updateContact(int id, String name, String phone, String email) async {
    final db = await _openDB();
    return await db.update(
      'contacts',
      {
        'name': name,
        'phone': phone,
        'email': email,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteContact(int id) async {
    final db = await _openDB();
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Optional: helper to close DB
  static Future<void> closeDB() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}



