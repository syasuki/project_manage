import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class TodoHistoryEntity {
  final int? id;
  final int? parent_id;
  final String title;
  final String text;
  DateTime dueDate = DateExtention.dateOnlyNow();

  TodoHistoryEntity(
      {this.id,
        required this.parent_id,
        required this.title,
        required this.text,
        required this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parent_id':parent_id,
      'title': title,
      'text': text,
      "dueDate": dueDate.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TodoHistoryEntity{id: $id,parent_id: $parent_id,title: $title ,text: $text,dueDate: $dueDate.toUtc().toIso8601String()}';
  }

  static Future<void> insert(TodoHistoryEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'todo_history',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TodoHistoryEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('todo_history');
    return List.generate(maps.length, (i) {
      return TodoHistoryEntity(
          id: maps[i]['id'],
          parent_id: maps[i]['parent_id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          dueDate: DateTime.parse(maps[i]['dueDate']).toLocal());
    });
  }

  static Future<void> update(TodoHistoryEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'todo_history',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'todo_history',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
