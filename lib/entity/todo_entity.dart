import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';
//"CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,note TEXT,status INTEGER,progress INTEGER, deadline TEXT,"
//                 "priority INTEGER,event_id INTEGER,section_id INTEGER,created_at TEXT,updated_at TEXT)"
class TaskEntity {
  final int? id;
  final String title;
  final String note;
  final int? status;
  final int? progress;
  final int? priority;
  final int? event_id;
  final int? section_id;
  DateTime deadline = DateExtention.dateOnlyNow();
  DateTime created_at = DateExtention.dateOnlyNow();
  DateTime updated_at = DateExtention.dateOnlyNow();

  TaskEntity(
      {this.id,
        required this.title,
        required this.note,
        required this.status,
        required this.progress,
        required this.priority,
        this.event_id,
        required this.section_id,
        required this.deadline,
        required this.created_at,
        required this.updated_at
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'status': status,
      'progress': progress,
      'priority': priority,
      'event_id': event_id,
      'section_id': section_id,
      "deadline": deadline.toUtc().toIso8601String(),
      "created_at": created_at.toUtc().toIso8601String(),
      "updated_at": updated_at.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id,title: $title ,note: $note,status: $status,progress: $progress,priority: $priority,event_id: $event_id'
        'section_id: $section_id,deadline: $deadline.toUtc().toIso8601String(),created_at: $created_at.toUtc().toIso8601String(),updated_at: $updated_at.toUtc().toIso8601String()}';
  }

  static Future<void> insert(TaskEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'task',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TaskEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('task');
    return List.generate(maps.length, (i) {
      return TaskEntity(
          id: maps[i]['id'],
          title: maps[i]['title'],
          note: maps[i]['note'],
          status: maps[i]['status'],
          progress: maps[i]['progress'],
          priority: maps[i]['priority'],
          event_id: maps[i]['event_id'],
          section_id: maps[i]['section_id'],
          deadline: DateTime.parse(maps[i]['deadline']).toLocal(),
          created_at: DateTime.parse(maps[i]['created_at']).toLocal(),
          updated_at: DateTime.parse(maps[i]['updated_at']).toLocal()
      );
    });
  }

  static Future<void> update(TaskEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'task',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'task',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
