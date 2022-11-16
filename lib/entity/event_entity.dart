import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class EventEntity {
  final int? id;
  final String title;
  final String text;
  DateTime dueDate = DateExtention.dateOnlyNow();

  EventEntity(
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
    return 'EventEntity{id: $id,title: $title ,text: $text,dueDate: $dueDate.toUtc().toIso8601String()}';
  }

  static Future<void> insert(EventEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'event',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<EventEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('event');
    return List.generate(maps.length, (i) {
      return EventEntity(
          id: maps[i]['id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          dueDate: DateTime.parse(maps[i]['dueDate']).toLocal());
    });
  }

  static Future<void> update(EventEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'event',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'event',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
