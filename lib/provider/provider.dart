import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pro_sche/model/event_model.dart';

import '../model/todo_model.dart';

/// Creates a [TaskList] and initialise it with pre-defined values.
final todoListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  var todoList = TaskList();
  todoList.initGet();
  return todoList;
});

/// Creates a [TaskList] and initialise it with pre-defined values.
final eventListProvider = StateNotifierProvider<EventList, List<Event>>((ref) {
  var list = EventList();
  list.initGet();
  return list;
});