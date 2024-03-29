import 'package:flutter/cupertino.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:pro_sche/translator/calender_translator.dart';
import 'package:state_notifier/state_notifier.dart';

import '../entity/event_entity.dart';
import '../entity/todo_entity.dart';
import '../entity/tracker_entity.dart';
import '../translator/todo_translator.dart';

@immutable
class CalenderCell {
  const CalenderCell({
    required this.targetDate,
    required this.todoList,
    required this.eventList,
  });

  final DateTime targetDate;
  final List<Task> todoList;
  final List<EventEntity> eventList;

  @override
  String toString() {
    return 'CalenderCell(description: $todoList, completed: $targetDate)';
  }
}




class CalenderModel extends StateNotifier<List<CalenderCell>> {
  CalenderModel() : super([]);

  /*
  Future<List<Todo>> init() async {
    var entity = await TodoEntity.get();
    return TodoTranslator.todoConvert(entity);
  }
  */
  Future<void> initGet() async {
    var entity = await TaskEntity.get();
    var evententity = await EventEntity.get();
    var tracker = await TaskTrackerEntity.get();
    state = CalenderTranslator.calenderConvert(entity,evententity,tracker);
  }
  Future<void> get() async {
    var entity = await TaskEntity.get();
    var evententity = await EventEntity.get();
    var tracker = await TaskTrackerEntity.get();
    state = CalenderTranslator.calenderConvert(entity,evententity,tracker);
  }

  Future<void> add(String description,DateTime targetDate) async {
    var entity = TaskEntity(title: 'title', note: description, status: 1, progress: 0, priority: 1, section_id: 1, deadline: targetDate, created_at: targetDate, updated_at: targetDate);
    await TaskEntity.insert(entity);
    var ret = await TaskEntity.get();
    //state = TodoTranslator.todoConvert(ret);
  }


  Future<void> edit(Task target,String description) async {
    var entity = TodoTranslator.todoModelConvert(target,description);
    await TaskEntity.update(entity);
    var ret = await TaskEntity.get();
    //state = TodoTranslator.todoConvert(ret);
  }

  Future<void> remove(Task target) async {
    await TaskEntity.delete(target.id);
    var ret = await TaskEntity.get();
    //state = TodoTranslator.todoConvert(ret);
  }
}