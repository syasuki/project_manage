import 'package:flutter/cupertino.dart';

@immutable
class TaskTracker {
  const TaskTracker({
    required this.id,
    required this.task_id,
    required this.note,
    required this.created_at,
    required this.updated_at,
  });

  final int? id;
  final int task_id;
  final String note;
  final DateTime created_at;
  final DateTime updated_at;

  @override
  String toString() {
    return 'TaskTracker(id: $id, task_id: $task_id)';
  }
}