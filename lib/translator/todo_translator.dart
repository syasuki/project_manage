
import 'package:pro_sche/util/date_extention.dart';
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../model/todo_model.dart';

class TodoTranslator {
  static const _uuid = Uuid();
  static List<Todo> todoConvert(List<TaskEntity> entityList) {
    var todoList = <Todo>[];
    for (var entity in entityList) {
      var todo = Todo(id: entity.id!,
        description: entity.note,
        targetDate: entity.deadline
      );
      todoList.add(todo);
    }
    return todoList;
  }
  static TaskEntity todoModelConvert(Todo model, String description) {
    var entity = TaskEntity(title: 'title', note: description, status: 1, progress: 0, priority: 1, section_id: 1, deadline: DateExtention.dateOnlyNow(), created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow());
    return entity;
  }
}