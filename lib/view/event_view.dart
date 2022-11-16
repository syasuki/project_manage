import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/todo_view.dart';

class Event extends HookConsumerWidget {
  const Event({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Scrollbar(
          child:ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              //const Title(),
              TextField(
                key: addTodoKey,
                decoration: const InputDecoration(
                  labelText: 'What needs to be done?',
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
                  /*
                  ref.read(todoListProvider.notifier).add(newTodoController.text,ref.watch(dateProvider));
                  ref.read(calenderListProvider.notifier).get();
                  newTodoController.clear();

                   */
                },
              ),
              ],
          ),
        ),
      ),
    );
  }
}
