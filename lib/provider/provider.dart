import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pro_sche/model/event_model.dart';
import 'package:pro_sche/model/section_model.dart';

import '../model/section_view_model.dart';
import '../model/todo_model.dart';
import '../util/date_extention.dart';

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

final sectionListProvider = StateNotifierProvider<SectionList, List<Section>>((ref) {
  var list = SectionList();
  list.initGet();
  return list;
});

final sectionPageProvider = StateNotifierProvider<SectionPageModel, SectionPage>((ref) {
  var model = SectionPageModel();
  model.initGet();
  return model;
});

final taskUpdateProvider = StateNotifierProvider<TaskModel, Task>((ref) {
  var model = TaskModel();
  return model;
});
