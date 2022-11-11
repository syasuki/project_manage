
import 'package:pro_sche/model/calender_model.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:pro_sche/translator/todo_translator.dart';
import 'package:pro_sche/util/date_extention.dart';

import '../entity/todo_entity.dart';

class CalenderTranslator {
  static List<CalenderCell> calenderConvert(List<TodoEntity> entityList) {
    var calenderList = <CalenderCell>[];


    var dates = <DateTime>{};
    for (var entity in entityList) {
      dates.add(entity.dueDate);
    }
    for(var date in dates){
      var todoList = <Todo>[];
      var filteredList = entityList.where((e) => e.dueDate == date).toList();
      var todoModels = TodoTranslator.todoConvert(filteredList);
      var cell = CalenderCell(targetDate: date, todoList: todoModels);
      calenderList.add(cell);
    }
    return calenderList;
  }
}