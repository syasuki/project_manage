import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/setting_view.dart';
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
          lastDate: new DateTime.now().add(new Duration(days: 360)));
      if (picked != null) {
        ref.read(dateProvider.notifier).state = picked;
      }
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("ホーム",
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
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
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
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "今日のアクション数",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  ),
                                  Text(
                                    "13回",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "今日のイベント数",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  ),
                                  Text(
                                    "13回",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "今週の進行具合",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  ),
                                  Text(
                                    "13%",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                minHeight: 10,
                                value: 0.4,
                              ),
                            ),
                          ),

                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      height: 80,
                                      width:
                                      (MediaQuery.of(context).size.width -
                                          101) /
                                          2,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey, //色
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text("期間間近タスク",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Helvetica Neue',
                                              ),),
                                            Text("53件",
                                              style: TextStyle(
                                                fontSize: 32,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Helvetica Neue',
                                              ),)
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      height: 80,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  101) /
                                              2,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey, //色
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text("最近動かタスク",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Helvetica Neue',
                                              ),),
                                            Text("53件",
                                              style: TextStyle(
                                                fontSize: 32,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Helvetica Neue',
                                              ),)
                                          ]),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                            icon: Icon(
                              Icons.list_alt,
                              size: 40,
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.5, //50%
                                70,
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color(0xff9941d8).withOpacity(0.6),
                            ),
                            onPressed: () {},
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
                            icon: Icon(
                              Icons.list_alt,
                              size: 40,
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.5, //50%
                                70,
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color(0xff9941d8).withOpacity(0.6),
                            ),
                            onPressed: () {},
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
                            Icon(
                              Icons.list_alt,
                              size: 90,
                              color: Colors.white70,
                            ),
                            Text("TODO登録",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica Neue',
                                ))
                          ]),
                      alignment: Alignment.center,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
