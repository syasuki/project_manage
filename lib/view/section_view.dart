import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:pro_sche/view/ui/pie_chart.dart';

class Section extends HookConsumerWidget {
  const Section({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    final _tab = <Tab>[
      Tab(text: 'iOS'),
      Tab(text: 'Andorid'),
      Tab(text: 'Flutter'),
      Tab(text: 'Laravel'),
      Tab(text: 'postgres'),
    ];

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        length: _tab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("項目", style: TextStyle(color: Colors.black87)),
            backgroundColor: Colors.grey[200],
            bottom: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black87,
              tabs: _tab,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black87,
                ),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Setting()))
                },
              ),
            ],
          ),
          body: TabBarView(children: <Widget>[
            SectionPageItem(),
            SectionPageItem(),
            SectionPageItem(),
          ]),
        ),
      ),
    );
  }
}

class SectionPageItem extends HookConsumerWidget {
  const SectionPageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "進捗率　60%",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica Neue',
              ),
            ),
            PieChartSample1(),
            Text(
              "タスク進捗割合 50%",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica Neue',
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: ["a", "b", "c", "a"]
                    .map((e) => SectionPageTaskVarietyItem())
                    .toList(),
              ),
            )
          ],
        ));
  }
}

class SectionPageTaskVarietyItem extends HookConsumerWidget {
  const SectionPageTaskVarietyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.grey[200],
      child: Container(
        height: (50),
        width: (MediaQuery.of(context).size.width - 41),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("実行済タスク"),
              Spacer(),
              Text(
                "12個",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica Neue',
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
