import 'package:flutter/cupertino.dart';
import 'package:pro_sche/entity/tracker_entity.dart';
import 'package:pro_sche/model/task_tracker_model.dart';
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
    required this.title,
    required this.description,
    required this.id,
    required this.status,
    required this.progress,
    required this.priority,
    required this.event_id,
    this.section_id,
    required this.trackers,
    required this.created_at,
    required this.updated_at,
    required this.targetDate,
    this.completed = false,
  });

  final int id;
  final String title;
  final String description;
  final int? status;
  final int? progress;
  final int? priority;
  final int? event_id;
  final int? section_id;
  final bool completed;
  final List<TaskTracker> trackers;
  final DateTime targetDate;
  final DateTime created_at;
  final DateTime updated_at;


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
  Future<void> get() async {
    var entity = await TaskEntity.get();
    state = TodoTranslator.todoConvert(entity);
  }
  Future<void> add(String title,String description,int status,int progress,int priority,DateTime targetDate) async {
    var entity = TaskEntity(title: title, note: description, status: status, progress: progress, priority: priority, section_id: 1, deadline: targetDate, created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow());
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
            title: todo.title,
            completed: !todo.completed,
            description: todo.description,
            targetDate: todo.targetDate,
            status: todo.status,
            progress: todo.progress,
            priority: todo.priority,
            event_id: todo.event_id,
            section_id: todo.section_id,
            trackers: todo.trackers,
            created_at: todo.created_at,
            updated_at: todo.updated_at,
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

class TaskModel extends StateNotifier<Task> {
  TaskModel() : super(Task(title: "", description: "", id: 1, status: 1, progress: 1, priority: 1, event_id: 1,trackers: <TaskTracker>[], created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow(), targetDate: DateExtention.dateOnlyNow()));


  Future<void> initGet(Task task) async {
    state = task;
  }
  Future<void> targetDateChange(DateTime targetDate) async {
    var entity = Task(title: state.title, description: state.description, id: state.id, status: state.status, progress: state.progress, priority: state.priority, event_id: state.event_id, trackers: state.trackers,created_at: state.created_at, updated_at: state.updated_at, targetDate: targetDate);
    state = entity;
  }

  Future<void> priorityChange(int priority) async {
    var entity = Task(title: state.title, description: state.description, id: state.id, status: state.status, progress: state.progress, priority: priority, event_id: state.event_id,trackers: state.trackers, created_at: state.created_at, updated_at: state.updated_at, targetDate: state.targetDate);
    state = entity;
  }

  Future<void> progressChange(int progress) async {
    var entity = Task(title: state.title, description: state.description, id: state.id, status: state.status, progress: progress, priority: state.priority, event_id: state.event_id,trackers: state.trackers, created_at: state.created_at, updated_at: state.updated_at, targetDate: state.targetDate);
    state = entity;
  }

  Future<void> statusChange(int status) async {
    var entity = Task(title: state.title, description: state.description, id: state.id, status: status, progress: state.progress, priority: state.priority, event_id: state.event_id,trackers: state.trackers, created_at: state.created_at, updated_at: state.updated_at, targetDate: state.targetDate);
    state = entity;
  }

  Future<void> edit(Task task,String title,String note, String tracker_comment) async {
    var entity = TodoTranslator.taskModelConvert(task,title,note);
    await TaskEntity.update(entity);
    var ret = await TaskEntity.get();
    var retList = TodoTranslator.todoConvert(ret);
    var retfirst = retList.firstWhere((element) => element.id == task.id);
    var retTracker = await addTracker(1, "note");
    print(retTracker);
    state = retfirst;
  }

  Future<List<TaskTrackerEntity>> addTracker(int task_id,String note) async {
    var entity = TaskTrackerEntity(
        task_id:task_id,
        note: note,
        created_at: DateExtention.dateOnlyNow(),
    updated_at: DateExtention.dateOnlyNow(),);
    await TaskTrackerEntity.insert(entity);

    var ret = await TaskTrackerEntity.get();
    return ret;
  }
}