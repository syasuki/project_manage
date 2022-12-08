import 'package:pro_sche/entity/section_entity.dart';
import 'package:pro_sche/util/date_extention.dart';

import '../entity/todo_entity.dart';
import '../model/section_view_model.dart';
import '../model/todo_model.dart';

class SectionTranslator {
  static SectionPage convert(List<TaskEntity> taskList,List<SectionEntity> sectionList) {
    var infos = <PageInfo>[];
    for (var entity in sectionList) {
      var page = PageInfo(tabName: entity.name, circleInfo: CircleInfo(values: []));
      infos.add(page);
    }
    return SectionPage(pageInfos: []);
  }
}