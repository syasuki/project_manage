
import 'package:pro_sche/util/date_extention.dart';

import '../entity/todo_entity.dart';
import '../model/todo_model.dart';

class TodoTranslator {
  static List<Task> todoConvert(List<TaskEntity> entityList) {
    var todoList = <Task>[];
    for (var entity in entityList) {
      var todo = Task(id: entity.id!,
        title: entity.title,
        description: entity.note,
        targetDate: entity.deadline
      );
      todoList.add(todo);
    }
    return todoList;
  }
  static TaskEntity todoModelConvert(Task model, String description) {
    var entity = TaskEntity(title: 'title', note: description, status: 1, progress: 0, priority: 1, section_id: 1, deadline: DateExtention.dateOnlyNow(), created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow());
    return entity;
  }
}