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
          backgroundColor: Colors.grey[200],
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

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
                                height: 170,
                                width: (MediaQuery.of(context).size.width - 61) / 2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      label: const Text(
                                        'スケジュール\n追加',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Helvetica Neue',
                                        ),
                                      ),
                                      icon: Icon(Icons.list_alt,size: 40,),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width * 0.5, //50%
                                          70,
                                        ),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff9941d8).withOpacity(0.6),
                                      ),
                                      onPressed: () {
                                      },
                                    ),
                                    ElevatedButton.icon(
                                      label: const Text(
                                          'プロジェクト\n追加',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                      ),
                                      icon: Icon(Icons.list_alt,size: 40,),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width * 0.5, //50%
                                          70,
                                        ),
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
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey, //色
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.list_alt,size: 90,color: Colors.white70,),
                                  Text("TODO登録",textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica Neue',))
                                ]
                              ),
                              alignment: Alignment.center,
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
