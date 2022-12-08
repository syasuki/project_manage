import 'package:flutter/cupertino.dart';
import 'package:pro_sche/entity/event_entity.dart';
import 'package:pro_sche/translator/calender_translator.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

import '../entity/todo_entity.dart';
import '../translator/todo_translator.dart';
import '../util/date_extention.dart';

/// A read-only description of a todo-item
@immutable
class Event {
  const Event({
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
class EventModel extends StateNotifier<Event>{
  EventModel(super.state);
  Future<void> add(String description,DateTime targetDate) async {
    var entity = EventEntity(title: 'title', note: description, isAll: 1, target_date: DateExtention.dateOnlyNow());
    await EventEntity.insert(entity);
    var ret = await EventEntity.get();
  }
}
/// An object that controls a list of [Event].
class EventList extends StateNotifier<List<Event>> {
  EventList() : super([]);


  Future<void> initGet() async {
    var entity = await EventEntity.get();
    //state = TodoTranslator.todoConvert(entity);
  }

  Future<void> add(String description,DateTime targetDate) async {
    var entity = EventEntity(title: description, note: description, isAll: 1, target_date: targetDate);
    await EventEntity.insert(entity);

    var ret = await EventEntity.get();
    //CalenderTranslator.todoConvert(ret);
    //state = TodoTranslator.todoConvert(ret);
  }


  Future<void> edit(Event target,String description) async {
    /*var entity = TodoTranslator.todoModelConvert(target,description);
    await EventEntity.update(entity);
    var ret = await TodoEntity.get();
    state = TodoTranslator.todoConvert(ret);

     */
  }

  Future<void> remove(Event target) async {
    await EventEntity.delete(target.id);
    var ret = await EventEntity.get();
    //state = TodoTranslator.todoConvert(ret);
  }
}