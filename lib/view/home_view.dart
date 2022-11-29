import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:pro_sche/view/ui/bar_chart.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

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


    return  Scaffold(
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.grey[200],
                      child: Container(
                          height: (MediaQuery.of(context).size.width - 41),
                          width: (MediaQuery.of(context).size.width - 41),
                          child: Text('Flutter'),
                          alignment: Alignment.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 150,
                                width: (MediaQuery.of(context).size.width - 61) / 2,
                                alignment: Alignment.center,
                                color: Colors.amber,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      child: const Text('追加'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff9941d8).withOpacity(0.6),
                                      ),
                                      onPressed: () {
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text('追加'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff9941d8).withOpacity(0.6),
                                      ),
                                      onPressed: () {
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              height: 150,
                              width: (MediaQuery.of(context).size.width - 61) / 2,
                              child: Text('Flutter'),
                              alignment: Alignment.center,
                              color: Colors.amber,
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
            ),
          ),
        ),
      );
    }
}
