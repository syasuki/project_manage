import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_view.dart';
import 'package:pro_sche/view/ui/bar_chart.dart';
import 'package:pro_sche/view/ui/bar_chart2.dart';
import 'package:pro_sche/view/ui/pie_chart.dart';
import 'package:toggle_switch/toggle_switch.dart';

final graghTabProvider = StateProvider<int>((ref) => 0);

class Achieve extends HookConsumerWidget {
  const Achieve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    int touchedIndex = 0;
    final indexprovider = ref.watch(graghTabProvider);

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
      appBar: AppBar(
        title: Text("実績",
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
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(outputFormat.format(ref.watch(dateProvider))),
                  Icon(Icons.arrow_forward_ios),
                  ElevatedButton(
                    child: const Text('日別'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("登録Todo",textAlign: TextAlign.center,),
                  Text("action数",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica Neue',
                    ),
                  ),
                  Text("完了Todo",textAlign: TextAlign.center,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("12個",textAlign: TextAlign.center),
                  Text("34回",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica Neue',
                    ),
                  ),
                  Text("12個",textAlign: TextAlign.center,),
                ],
              ),
              const SizedBox(height: 15),
              ToggleSwitch(
                minWidth: (MediaQuery.of(context).size.width - 41) / 2,
                minHeight: 25,
                cornerRadius: 20.0,
                activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: indexprovider,
                totalSwitches: 2,
                labels: const ['時系列', '割合'],
                radiusStyle: true,
                onToggle: (index) {
                  //print('switched to: $index');
                  ref.read(graghTabProvider.notifier).state =
                      index!;
                },
              ),
              const SizedBox(height: 15),
              indexprovider == 0 ? BarChartSample4() : PieChartSample1(),
            ],
          ),
          ),
        ),
      ),);
  }
}
