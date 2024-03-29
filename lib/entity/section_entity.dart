import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/app_database.dart';

class SectionEntity {
  final int? id;
  final String name;
  final String description;
  DateTime created_at = DateExtention.dateOnlyNow();
  DateTime updated_at = DateExtention.dateOnlyNow();

  SectionEntity(
      {this.id,
        required this.name,
        required this.description,
        required this.created_at,
        required this.updated_at
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      "created_at": created_at.toUtc().toIso8601String(),
      "updated_at": updated_at.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SectionEntity{id: $id,name: $name ,description: $description,created_at: $created_at.toUtc().toIso8601String(),updated_at: $updated_at.toUtc().toIso8601String()}';
  }

  static Future<void> insert(SectionEntity entity) async {
    final Database db = await AppDatabase.database;
    await db.insert(
      'section',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<SectionEntity>> get() async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('section');
    return List.generate(maps.length, (i) {
      return SectionEntity(
          id: maps[i]['id'],
          name: maps[i]['name'],
          description: maps[i]['description'],
          created_at: DateTime.parse(maps[i]['created_at']).toLocal(),
          updated_at: DateTime.parse(maps[i]['updated_at']).toLocal()
      );
    });
  }

  static Future<void> update(SectionEntity entity) async {
    final db = await AppDatabase.database;
    await db.update(
      'section',
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'section',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
