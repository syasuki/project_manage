import 'package:flutter/cupertino.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:pro_sche/translator/calender_translator.dart';
import 'package:state_notifier/state_notifier.dart';

import '../entity/event_entity.dart';
import '../entity/todo_entity.dart';
import '../translator/todo_translator.dart';

@immutable
class SectionPage {
  const SectionPage({
    required this.tabName,
    required this.todoList,
    required this.eventList,
  });

  final String tabName;
  final List<Task> todoList;
  final List<EventEntity> eventList;

  @override
  String toString() {
    return 'CalenderCell(description: $todoList, completed: )';
  }
}

class PageInfo {
  const PageInfo({
    required this.tabName,
    required this.todoList,
    required this.eventList,
  });

  final String tabName;
  final List<Task> todoList;
  final List<EventEntity> eventList;

  @override
  String toString() {
    return 'CalenderCell(description: $todoList, completed: )';
  }
}



class SectionPageModel extends StateNotifier<List<SectionPage>> {
  SectionPageModel() : super([]);

  /*
  Future<List<Todo>> init() async {
    var entity = await TodoEntity.get();
    return TodoTranslator.todoConvert(entity);
  }
  */
  Future<void> initGet() async {
    /*
    var entity = await TaskEntity.get();
    var evententity = await EventEntity.get();
    state = CalenderTranslator.calenderConvert(entity,evententity);
     */
  }
  Future<void> get() async {
    /*
    var entity = await TaskEntity.get();
    var evententity = await EventEntity.get();
    state = CalenderTranslator.calenderConvert(entity,evententity);
     */
  }
}