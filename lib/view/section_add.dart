import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../calender.dart';
import '../provider/provider.dart';

class SectionAdd extends HookConsumerWidget {
  const SectionAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final discriptController = useTextEditingController();

    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("項目追加")),
        body: Scrollbar(
          child:ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              //const Title(),
              TextField(
                key: addTodoKey,
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: '項目名',
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
                maxLines: 5,
                minLines: 5,

                controller: discriptController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: '説明',
                  //この一行
                  alignLabelWithHint: true,
                ),
                onSubmitted: (value) {
                  //ref.read(todoListProvider.notifier).add(newTodoController.text);
                  //newTodoController.clear();
                },
              ),
              ElevatedButton(
                child: const Text('追加'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff9941d8).withOpacity(0.6),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  ref.read(sectionListProvider.notifier).add(nameController.text,discriptController.text);
                  ref.read(calenderListProvider.notifier).get();
                  nameController.clear();
                  discriptController.clear();
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
