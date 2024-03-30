import 'package:note_pad_with_database/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesRepository {
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

    static Future <Database> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<void> insert({required Note note}) async {
    final db = await _database();
    print("INSERTION ${note.toMap()}");
    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    print("Retrieved ${maps.length} notes from the database."); // Add this line for debugging
    // //     var list=List.generate(maps.length, (i) {
    // //   return Note(
    // //     id: maps[i]['id'] as int,
    // //     title: maps[i]['title'] as String,
    // //     description: maps[i]['description'] as String,
    // //     createAt: DateTime.parse(maps[i]['createdAt'] as String),
    // //   );
    // // });
    // print(maps);

    // return [
    //     Note(title: "Hello", description: "WORLD", createAt: DateTime.now()),
    //     Note(title: "Hello", description: "WORLD", createAt: DateTime.now()),
    //     Note(title: "Hello", description: "WORLD", createAt: DateTime.now()),
    //     Note(title: "Hello", description: "WORLD", createAt: DateTime.now())
    // ];
print(maps);
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id']??"--" as int,
        title: maps[i]['title']??"--" as String,
        description: maps[i]['description']??"--" as String,
        createAt: DateTime.parse(maps[i]['createdAt']??DateTime.now() as String),
      );
    });
  }
 
 static update({required Note note})async{
  // Get a reference to the database.
  final db = await _database();

  
  await db.update(
    _tableName,
    note.toMap(),
    where: 'id = ?',
    
    whereArgs: [note.id],
  );
 }

 static delete({required Note note})async{

  final db = await _database();

  // Remove the Dog from the database.
  await db.delete(
    _tableName,
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [note.id],
  );

 }

}
