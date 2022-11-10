
import 'package:pro_sche/model/calender_model.dart';

import '../entity/todo_entity.dart';

class CalenderTranslator {
  static List<CalenderModel> todoConvert(List<TodoEntity> entityList) {
    var calenderList = <CalenderModel>[];

    var date = DateTime.now();
    var dates = <DateTime>{};
    for (var entity in entityList) {
      dates.add(entity.dueDate);
    }
    return calenderList;
  }
}