import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class TaskTrackerEntity {
  final int? id;
  final int task_id;
  final String note;
  DateTime created_at = DateExtention.dateOnlyNow();
  DateTime updated_at = DateExtention.dateOnlyNow();

  TaskTrackerEntity(
      {this.id,
        required this.task_id,
        required this.note,
        required this.created_at,
        required this.updated_at});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id':task_id,
      'note': note,
      'created_at': created_at.toUtc().toIso8601String(),
      "updated_at": updated_at.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TaskTrackerEntity{id: $id,task_id: $task_id,note: $note ,created_at: $created_at.toUtc().toIso8601String(),updated_at: $updated_at.toUtc().toIso8601String()}';
  }

  static Future<void> insert(TaskTrackerEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'task_tracker',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TaskTrackerEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('task_tracker');
    return List.generate(maps.length, (i) {
      return TaskTrackerEntity(
          id: maps[i]['id'],
          task_id: maps[i]['task_id'],
          note: maps[i]['note'],
          created_at: DateTime.parse(maps[i]['created_at']).toLocal(),
          updated_at: DateTime.parse(maps[i]['updated_at']).toLocal());
    });
  }

  static Future<void> update(TaskTrackerEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'task_tracker',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'task_tracker',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
