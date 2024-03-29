import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/model/todo_model.dart';
import 'package:pro_sche/util/date_extention.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../calender.dart';
import '../provider/provider.dart';

class TodoUpdate extends HookConsumerWidget {
  const TodoUpdate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskUpdateProvider);
    final titleController = useTextEditingController(text: task.title);
    final noteController = useTextEditingController(text: task.description);
    final trackerController = useTextEditingController();
    var outputFormat = DateFormat('yyyy-MM-dd');
    void onPressedRaisedButton() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: task.targetDate,
          firstDate: new DateTime(2018),
          lastDate: new DateTime.now().add(new Duration(days: 360))
      );
      if (picked != null) {
        ref.read(taskUpdateProvider.notifier).targetDateChange(picked);
      }
    }


    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task更新",
              style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.grey[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black87,
              ),
              onPressed: () =>{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Setting()))
              },
            ),
          ],
        ),
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
                  labelText: '題名',
                  //この一行
                  alignLabelWithHint: true,
                  //labelText: 'What needs to be done?',
                ),
              ),
              TextField(
                key: addTodoKey,
                maxLines: 5,
                minLines: 5,
                controller: noteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: '説明',
                  //この一行
                  alignLabelWithHint: true,
                  //labelText: 'What needs to be done?',
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                ),
                child: Text(outputFormat.format(task.targetDate)),
                onPressed: onPressedRaisedButton,
              ),
              DropdownButton(
                //4
                items: const [
                  //5
                  DropdownMenuItem(
                    child: Text('低め'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('通常'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('高め'),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text('緊急'),
                    value: 4,
                  ),
                ],
                onChanged: (int? value) {
                  ref.read(taskUpdateProvider.notifier).priorityChange(value!);
                },
                //7
                value: task.priority,
              ),
              DropdownButton(
                //4
                items: const [
                  //5
                  DropdownMenuItem(
                    child: Text('0%'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('10%'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('20%'),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text('30%'),
                    value: 4,
                  ),
                ],
                onChanged: (int? value) {
                  ref.read(taskUpdateProvider.notifier).progressChange(value!);
                },
                //7
                value: task.progress,
              ),
              DropdownButton(
                //4
                items: const [
                  //5
                  DropdownMenuItem(
                    child: Text('新規'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('進行中'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('終了'),
                    value: 3,
                  ),
                ],
                onChanged: (int? value) {
                  ref.read(taskUpdateProvider.notifier).statusChange(value!);
                },
                //7
                value: task.status,
              ),
              TextField(
                key: addTodoKey,
                maxLines: 5,
                minLines: 5,
                controller: trackerController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'コメント',
                  //この一行
                  alignLabelWithHint: true,
                  //labelText: 'What needs to be done?',
                ),
              ),
              ElevatedButton(
                child: const Text('追加'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff9941d8).withOpacity(0.6),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  //ref.read(todoListProvider.notifier).add(titleController.text,noteController.text,statusSelected,progressSelected,selected,ref.watch(dateProvider));
                  ref.read(taskUpdateProvider.notifier).edit(task,titleController.text,noteController.text,trackerController.text);
                  ref.read(todoListProvider.notifier).get();
                  ref.read(calenderListProvider.notifier).get();
                  titleController.clear();
                  noteController.clear();
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
