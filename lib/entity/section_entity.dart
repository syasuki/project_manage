import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class SectionEntity {
  final int? id;
  final String title;
  final String text;
  DateTime dueDate = DateTime.now();

  SectionEntity(
      {this.id,
        required this.title,
        required this.text,
        required this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      "dueDate": dueDate.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id,title: $title ,text: $text,dueDate: $dueDate.toUtc().toIso8601String()}';
  }

  static Future<void> insert(SectionEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'todo',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<SectionEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return SectionEntity(
          id: maps[i]['id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          dueDate: DateTime.parse(maps[i]['dueDate']).toLocal());
    });
  }

  static Future<void> update(SectionEntity entity) async {
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
