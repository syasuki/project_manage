import 'package:flutter/cupertino.dart';
import 'package:pro_sche/translator/calender_translator.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../translator/todo_translator.dart';
import '../util/date_extention.dart';

/// A read-only description of a todo-item
@immutable
class Task {
  const Task({
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

/// An object that controls a list of [Task].
class TaskList extends StateNotifier<List<Task>> {
  TaskList() : super([]);

  /*
  Future<List<Todo>> init() async {
    var entity = await TodoEntity.get();
    return TodoTranslator.todoConvert(entity);
  }
  */
  Future<void> initGet() async {
    var entity = await TaskEntity.get();
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
  Future<void> add(String description,DateTime targetDate) async {
    var entity = TaskEntity(title: 'title', note: description, status: 1, progress: 0, priority: 1, section_id: 1, deadline: targetDate, created_at: targetDate, updated_at: targetDate);
    await TaskEntity.insert(entity);

    var ret = await TaskEntity.get();
    //CalenderTranslator.todoConvert(ret);
    state = TodoTranslator.todoConvert(ret);
  }

  void toggle(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Task(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
            targetDate: todo.targetDate,
          )
        else
          todo,
    ];
  }

  Future<void> edit(Task target,String description) async {
    var entity = TodoTranslator.todoModelConvert(target,description);
    await TaskEntity.update(entity);
    var ret = await TaskEntity.get();
    state = TodoTranslator.todoConvert(ret);
  }

  Future<void> remove(Task target) async {
    await TaskEntity.delete(target.id);
    var ret = await TaskEntity.get();
    state = TodoTranslator.todoConvert(ret);
  }
}