import 'package:flutter/cupertino.dart';
import 'package:pro_sche/translator/calender_translator.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../translator/todo_translator.dart';

/// A read-only description of a todo-item
@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    required this.targetDate,
    this.completed = false,
  });

  final int id;
  final String description;
  final bool completed;
  final DateTime targetDate;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

/// An object that controls a list of [Todo].
class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  /*
  Future<List<Todo>> init() async {
    var entity = await TodoEntity.get();
    return TodoTranslator.todoConvert(entity);
  }
  */
  Future<void> initGet() async {
    var entity = await TodoEntity.get();
    state = TodoTranslator.todoConvert(entity);
  }
/*
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: 1,
        description: description,
      ),
    ];
  }*/
  Future<void> add(String description) async {
    var entity = TodoEntity(title: 'title', text: description, dueDate: DateTime.now());
    await TodoEntity.insert(entity);

    var ret = await TodoEntity.get();
    CalenderTranslator.todoConvert(ret);
    state = TodoTranslator.todoConvert(ret);
  }

  void toggle(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
            targetDate: todo.targetDate,
          )
        else
          todo,
    ];
  }

  /*
  void edit({required int id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }
*/
  Future<void> edit(Todo target,String description) async {
    var entity = TodoTranslator.todoModelConvert(target,description);
    await TodoEntity.update(entity);
    var ret = await TodoEntity.get();
    state = TodoTranslator.todoConvert(ret);
  }
/*
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

 */
  Future<void> remove(Todo target) async {
    await TodoEntity.delete(target.id);
    var ret = await TodoEntity.get();
    state = TodoTranslator.todoConvert(ret);
  }
}