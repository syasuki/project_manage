import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_view.dart';

class Section extends HookConsumerWidget {
  const Section({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    final _tab = <Tab> [
      Tab( text:'Car'),
      Tab( text:'Bicycle'),
      Tab( text:'Boat'),
    ];

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
        child: DefaultTabController(
        length: _tab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("項目",
                style: TextStyle(color: Colors.black87)),
            backgroundColor: Colors.grey[200],
            bottom: TabBar(
              tabs: _tab,
            ),
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
          body: TabBarView(
              children: <Widget> [
                Text("a"),
                Text("b"),
                Text("b"),
              ]
          ),
        ),
        ),
      );
  }
}
