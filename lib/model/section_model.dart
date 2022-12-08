import 'package:flutter/cupertino.dart';
import 'package:pro_sche/entity/section_entity.dart';
import 'package:pro_sche/util/date_extention.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// A read-only description of a todo-item
@immutable
class Section {
  const Section({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Section(description: $description, completed: $completed)';
  }
}

/// An object that controls a list of [Todo].
class SectionList extends StateNotifier<List<Section>> {
  SectionList([List<Section>? initialSections]) : super(initialSections ?? []);

  Future<void> initGet() async {
    var ret = await SectionEntity.get();
    //CalenderTranslator.todoConvert(ret);
    //state = TodoTranslator.todoConvert(ret);

  }

  Future<void> add(String name,String description) async {
    var entity = SectionEntity(name: name, description: description,created_at: DateExtention.dateOnlyNow(), updated_at: DateExtention.dateOnlyNow());
    await SectionEntity.insert(entity);
    var ret = await SectionEntity.get();
    //CalenderTranslator.todoConvert(ret);
    //state = TodoTranslator.todoConvert(ret);

  }

  void edit({required String id, required String description}) {
    state = [
      for (final section in state)
        if (section.id == id)
          Section(
            id: section.id,
            completed: section.completed,
            description: description,
          )
        else
          section,
    ];
  }

  void remove(Section target) {
    state = state.where((section) => section.id != target.id).toList();
  }
}