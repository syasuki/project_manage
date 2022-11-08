import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_sche/main.dart';
import 'package:pro_sche/view/todo_view.dart';

import 'calender_view.dart';
import 'folder_view.dart';

final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.home);

enum ViewType { home, info }

class BaseTabView extends ConsumerWidget {
  BaseTabView({Key? key}) : super(key: key);

  final widgets = [
    const CalenderPage(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(baseTabViewProvider.state);
    return Scaffold(
      appBar: AppBar(title: Text(view.state.name)),
      body: widgets[view.state.index],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'カレンダー'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'リスト')
        ],
        currentIndex: view.state.index,
        onTap: (int index) => view.update((state) => ViewType.values[index]),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}