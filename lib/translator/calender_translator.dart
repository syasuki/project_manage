
import 'package:pro_sche/model/calender_model.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:pro_sche/translator/todo_translator.dart';
import 'package:pro_sche/util/date_extention.dart';

import '../entity/event_entity.dart';
import '../entity/todo_entity.dart';

class CalenderTranslator {
  static List<CalenderCell> calenderConvert(List<TaskEntity> entityList,List<EventEntity> eventList) {
    var calenderList = <CalenderCell>[];


    var dates = <DateTime>{};
    for (var entity in entityList) {
      dates.add(entity.deadline);
    }
    for (var entity in eventList) {
      dates.add(entity.target_date);
    }
    for(var date in dates){
      var filteredList = entityList.where((e) => e.deadline == date).toList();
      var filteredEventList = eventList.where((e) => e.target_date == date).toList();
      var todoModels = TodoTranslator.todoConvert(filteredList);
      var cell = CalenderCell(targetDate: date, todoList: todoModels,eventList: filteredEventList);
      calenderList.add(cell);
    }
    return calenderList;
  }
}