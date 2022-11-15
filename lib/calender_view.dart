import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          autoHide: Duration(seconds: 2),
          title: 'Succes',
          desc:
          'Dialog description here..................................................',
          btnOkOnPress: () {
          debugPrint('OnClcik');
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
          },
          ).show()
          },
          child: Icon(Icons.add)
      ),
    );
  }
}