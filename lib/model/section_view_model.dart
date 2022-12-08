import 'package:flutter/cupertino.dart';
import 'package:pro_sche/entity/section_entity.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:state_notifier/state_notifier.dart';

import '../entity/event_entity.dart';

@immutable
class SectionPage {
  const SectionPage({
    required this.pageInfos,
  });
  final List<PageInfo> pageInfos;

}

class PageInfo {
  const PageInfo({
    required this.tabName,
    required this.circleInfo,
  });

  final String tabName;
  final CircleInfo circleInfo;

}
class CircleInfo {
  const CircleInfo({
    required this.values,
  });
  final List<CirclePart> values;
}
class CirclePart {
  const CirclePart({
    required this.value,
    required this.label,
  });
  final int value;
  final String label;
}


class SectionPageModel extends StateNotifier<SectionPage> {
  SectionPageModel() : super(SectionPage(pageInfos: []));


  Future<void> initGet() async {
    var entity = await SectionEntity.get();
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