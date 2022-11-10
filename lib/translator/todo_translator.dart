
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../model/todo_model.dart';

class TodoTranslator {
  static const _uuid = Uuid();
  static List<Todo> todoConvert(List<TodoEntity> entityList) {
    var todoList = <Todo>[];
    for (var entity in entityList) {
      var todo = Todo(id: entity.id.toString(),
        description: entity.text);
      todoList.add(todo);
    }
    return todoList;
  }
}