import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_sche/main.dart';
import 'package:pro_sche/view/section_view.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_view.dart';

import 'calender_view.dart';
import 'folder_view.dart';

final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.home);

enum ViewType { calender, home ,section,setting}

class BaseTabView extends ConsumerWidget {
  BaseTabView({Key? key}) : super(key: key);

  final widgets = [
    const CalenderPage(),
    const Home(),
    const Section(),
    const Setting()
  ];

  String getViewName(String name){
    var text = "";
    switch(name) {
      case 'calender':
        text = "カレンダー";
        break;
      case 'home':
        text = "リスト";
        break;
      case 'section':
        text = "項目";
        break;
      case 'setting':
        text = "設定";
        break;
      default:
        text = "設定";
    }
    return text;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(baseTabViewProvider.state);
    return Scaffold(
      appBar: AppBar(title: Text(getViewName(view.state.name))),
      body: widgets[view.state.index],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'カレンダー'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'リスト'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '項目'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
        ],
        currentIndex: view.state.index,
        onTap: (int index) => view.update((state) => ViewType.values[index]),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}