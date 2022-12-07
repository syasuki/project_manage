import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class EventEntity {
  final int? id;
  final String title;
  final String note;
  final int isAll;
  DateTime target_date = DateExtention.dateOnlyNow();
  DateTime? start_time;
  DateTime? end_time;
  DateTime? created_at;
  DateTime? updated_at = DateExtention.dateOnlyNow();

  EventEntity(
      {this.id,
        required this.title,
        required this.note,
        required this.isAll,
        required this.target_date,
        this.start_time,
        this.end_time,
        this.created_at,
        this.updated_at
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      "isAll": isAll,
      "target_date":target_date.toUtc().toIso8601String(),
      "start_time":start_time?.toUtc().toIso8601String(),
      "end_time":end_time?.toUtc().toIso8601String(),
      "created_at":created_at?.toUtc().toIso8601String(),
      "updated_at":updated_at?.toUtc().toIso8601String()
    };
  }

  @override
  String toString() {
    return 'EventEntity{id: $id,title: $title ,text: $note,target_date: $target_date.toUtc().toIso8601String()}';
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
          note: maps[i]['note'],
          isAll: maps[i]['isAll'],
          target_date: DateTime.parse(maps[i]['target_date']).toLocal(),
          start_time: maps[i]['start_time'] != null ? DateTime.parse(maps[i]['start_time']).toLocal() : null,
          end_time: maps[i]['end_time'] != null ? DateTime.parse(maps[i]['end_time']).toLocal() : null,
          created_at: maps[i]['created_at'] != null ? DateTime.parse(maps[i]['created_at']).toLocal() : null,
          updated_at: maps[i]['updated_at'] != null ? DateTime.parse(maps[i]['updated_at']).toLocal() : null
      );
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
