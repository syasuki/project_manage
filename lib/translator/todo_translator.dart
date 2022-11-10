
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../model/todo_model.dart';

class TodoTranslator {
  static const _uuid = Uuid();
  static List<Todo> todoConvert(List<TodoEntity> entityList) {
    var todoList = <Todo>[];
    for (var entity in entityList) {
      var todo = Todo(id: entity.id!,
        description: entity.text,
        targetDate: entity.dueDate
      );
      todoList.add(todo);
    }
    return todoList;
  }
  static TodoEntity todoModelConvert(Todo model, String description) {
    var entity = TodoEntity(id: model.id ,title: "", text: description, dueDate: DateTime.now());
    return entity;
  }
}