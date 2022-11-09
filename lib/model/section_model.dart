import 'package:flutter/cupertino.dart';
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

  void add(String description) {
    state = [
      ...state,
      Section(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final section in state)
        if (section.id == id)
          Section(
            id: section.id,
            completed: !section.completed,
            description: section.description,
          )
        else
          section,
    ];
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