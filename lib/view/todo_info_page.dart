import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_update_view.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../calender.dart';
import '../entity/enum_entity.dart';
import '../model/todo_model.dart';
import '../provider/provider.dart';

class TodoInfoPage extends HookConsumerWidget {
  final Task task;
  const TodoInfoPage(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTodoController = useTextEditingController(text: task.title);
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
        appBar: AppBar(
          title: Text("task確認",
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              //const Title(),
              //Text("題名"),
              Text(
                task.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica Neue',
                ),
              ),
              const SizedBox(height: 15),
              Text("期日"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(outputFormat.format(task.targetDate)),
              ),
              Text("ステータス"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(EntityUtil.statusText(task.status!)),
              ),
              Text("優先度"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(EntityUtil.priorityText(task.priority!)),
              ),
              Text("進捗"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(task.progress.toString() + "%"),
              ),

              Text("説明"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(task.description),
              ),


              ElevatedButton(
                child: const Text('更新'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff9941d8).withOpacity(0.6),
                  onPrimary: Colors.white,
                ),
                onPressed: (){
                  ref.read(taskUpdateProvider.notifier).initGet(task);
                  // フローティングアクションボタンを押された時の処理.
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TodoUpdate()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
