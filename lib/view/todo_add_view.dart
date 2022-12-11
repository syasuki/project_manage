import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../calender.dart';
import '../provider/provider.dart';

final isSelectedItemProvider = StateProvider<int>((ref) => 2);
final isSelectedProgresssItemProvider = StateProvider<int>((ref) => 1);
final isSelectedStatusItemProvider = StateProvider<int>((ref) => 1);
class TodoAdd extends HookConsumerWidget {
  const TodoAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final noteController = useTextEditingController();
    var outputFormat = DateFormat('yyyy-MM-dd');
    final selected = ref.watch(isSelectedItemProvider);
    final progressSelected = ref.watch(isSelectedProgresssItemProvider);
    final statusSelected = ref.watch(isSelectedStatusItemProvider);

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
        appBar: AppBar(title: Text("TodoAdd")),
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
                child: Text(outputFormat.format(ref.watch(dateProvider))),
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
                  ref.read(isSelectedItemProvider.notifier).state = value!;
                },
                //7
                value: selected,
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
                  ref.read(isSelectedProgresssItemProvider.notifier).state = value!;
                },
                //7
                value: progressSelected,
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
                  ref.read(isSelectedStatusItemProvider.notifier).state = value!;
                },
                //7
                value: statusSelected,
              ),
              ElevatedButton(
                child: const Text('追加'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff9941d8).withOpacity(0.6),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  ref.read(todoListProvider.notifier).add(titleController.text,noteController.text,statusSelected,progressSelected,selected,ref.watch(dateProvider));
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
