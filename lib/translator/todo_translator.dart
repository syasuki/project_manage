
import 'package:pro_sche/util/date_extention.dart';

import '../entity/todo_entity.dart';
import '../model/todo_model.dart';

class TodoTranslator {
  static List<Task> todoConvert(List<TaskEntity> entityList) {
    var todoList = <Task>[];
    for (var entity in entityList) {
      var todo = Task(
        id: entity.id!,
        title: entity.title,
        description: entity.note,
        targetDate: entity.deadline,
        status: entity.status,
        progress: entity.progress,
        priority: entity.priority,
        event_id: entity.event_id,
        section_id: entity.section_id,
        created_at: entity.created_at,
        updated_at: entity.updated_at,
      );
      todoList.add(todo);
    }
    return todoList;
  }
  static TaskEntity todoModelConvert(Task model, String description) {
    var entity = TaskEntity(title: 'title', note: description, status: 1, progress: 0, priority: 1, section_id: 1, deadline: DateExtention.dateOnlyNow(), created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow());
    return entity;
  }

  static TaskEntity taskModelConvert(Task model, String title, String note) {
    var entity = TaskEntity(
      id: model.id!,
      title: title,
      note: note,
      deadline: model.targetDate,
      status: model.status,
      progress: model.progress,
      priority: model.priority,
      event_id: model.event_id,
      section_id: model.section_id,
      created_at: model.created_at,
      updated_at: model.updated_at,
    );
    return entity;
  }
}