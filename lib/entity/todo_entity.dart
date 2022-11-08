import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class TodoEntity {
  final int? id;
  final String title;
  final String text;
  DateTime dueDate = DateTime.now();
  final int hour;
  final int minutes;
  int isAllday = 0;
  String? imagePass = '';

  TodoEntity(
      {this.id,
        required this.title,
        required this.text,
        required this.dueDate,
        required this.hour,
        required this.minutes,
        required this.isAllday,
        required this.imagePass});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      "dueDate": dueDate.toUtc().toIso8601String(),
      'hour': hour,
      'minutes': minutes,
      'isAllday': isAllday,
      'imagePass': imagePass,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id,title: $title ,text: $text,dueDate: $dueDate.toUtc().toIso8601String(),hour: $hour,minutes:$minutes,isAllday:$isAllday,imagePass : $imagePass}';
  }

  static Future<void> insert(TodoEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'todo',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TodoEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return TodoEntity(
          id: maps[i]['id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          dueDate: DateTime.parse(maps[i]['dueDate']).toLocal(),
          hour: maps[i]['hour'],
          minutes: maps[i]['minutes'],
          isAllday: maps[i]['isAllday'],
          imagePass: maps[i]['imagePass']);
    });
  }

  static Future<void> update(TodoEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'todo',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'todo',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
