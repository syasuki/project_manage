import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../calender.dart';
import '../provider/provider.dart';

class EventAdd extends HookConsumerWidget {
  const EventAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final noteController = useTextEditingController();
    var outputFormat = DateFormat('yyyy-MM-dd');

    void onPressedRaisedButton() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: ref.watch(dateProvider),
          firstDate: new DateTime(2018),
          lastDate: new DateTime.now().add(new Duration(days: 360))
      );
      if (picked != null) {
        ref.read(dateProvider.notifier).state = picked;
      }
    }


    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("EventAdd")),
        body: Scrollbar(
          child:ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              //const Title(),
              TextField(
                key: addTodoKey,
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'タイトル',
                  //この一行
                  alignLabelWithHint: true,
                  //labelText: 'What needs to be done?',
                ),
                onSubmitted: (value) {
                  //ref.read(todoListProvider.notifier).add(newTodoController.text);
                  //newTodoController.clear();
                },
              ),
              TextField(
                key: addTodoKey,
                maxLines: 3,
                minLines: 3,

                controller: noteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: '内容',
                  //この一行
                  alignLabelWithHint: true,
                ),
                onSubmitted: (value) {
                  //ref.read(todoListProvider.notifier).add(newTodoController.text);
                  //newTodoController.clear();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                ),
                child: Text(outputFormat.format(ref.watch(dateProvider))),
                onPressed: onPressedRaisedButton,
              ),
              ElevatedButton(
                child: const Text('追加'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff9941d8).withOpacity(0.6),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  ref.read(eventListProvider.notifier).add(titleController.text,ref.watch(dateProvider));
                  ref.read(calenderListProvider.notifier).get();
                  titleController.clear();
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: false,
                    autoHide: Duration(seconds: 2),
                    title: 'Succes',
                    desc:
                    '登録完了',
                    btnOkOnPress: () {
                      debugPrint('OnClcik');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      //debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
