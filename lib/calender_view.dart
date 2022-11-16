import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_sche/view/event_view.dart';

import 'calender.dart';
import 'folder_view.dart';
import 'main.dart';

class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: Center(
        child: CalendarPageView()
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            // フローティングアクションボタンを押された時の処理.
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Event()))
          },
          child: Icon(Icons.add)
      ),
    );
  }
}