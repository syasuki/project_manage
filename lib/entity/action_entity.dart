import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class ActionEntity {
  final int? id;
  final String context;
  DateTime created_at = DateExtention.dateOnlyNow();

  ActionEntity(
      {this.id,
        required this.context,
        required this.created_at,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'context': context,
      "created_at": created_at.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ActionEntity{id: $id,context: $context ,created_at: $created_at.toUtc().toIso8601String()}';
  }

  static Future<void> insert(ActionEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'action',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ActionEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('action');
    return List.generate(maps.length, (i) {
      return ActionEntity(
          id: maps[i]['id'],
          context: maps[i]['context'],
          created_at: DateTime.parse(maps[i]['created_at']).toLocal(),
      );
    });
  }

  static Future<void> update(ActionEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'action',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'action',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
