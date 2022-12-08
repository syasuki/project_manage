import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pro_sche/model/calender_model.dart';
import 'package:pro_sche/model/todo_model.dart';

final _currentIndex = StateProvider<int>((ref) {
  return 1200;
});
final calenderListProvider =
    StateNotifierProvider<CalenderModel, List<CalenderCell>>((ref) {
  var calenderList = CalenderModel();
  calenderList.initGet();
  return calenderList;
});

class CalendarPageView extends HookConsumerWidget {
  const CalendarPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleMonth =
        ref.watch(_currentIndex).visibleDateTime.month.monthName;
    final visibleYear =
        ref.watch(_currentIndex).visibleDateTime.year.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            visibleYear + "年 " + visibleMonth,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: PageController(initialPage: 1200),
            itemBuilder: (context, index) {
              return CalendarPage(index.visibleDateTime);
            },
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              ref.read(_currentIndex.notifier).state = index;
            },
          ),
        ),
      ],
    );
  }
}

class CalendarPage extends HookConsumerWidget {
  const CalendarPage(
    this.visiblePageDate, {
    Key? key,
  }) : super(key: key);

  final DateTime visiblePageDate;

  List<DateTime> _getCurrentDates(DateTime dateTime) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDate(dateTime);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDate(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDates = _getCurrentDates(visiblePageDate);
    return Column(
      children: [
        DaysOfTheWeek(),
        DatesRow(
          dates: currentDates.getRange(0, 7).toList(),
        ),
        DatesRow(
          dates: currentDates.getRange(7, 14).toList(),
        ),
        DatesRow(
          dates: currentDates.getRange(14, 21).toList(),
        ),
        DatesRow(
          dates: currentDates.getRange(21, 28).toList(),
        ),
        DatesRow(
          dates: currentDates.getRange(28, 35).toList(),
        ),
        DatesRow(
          dates: currentDates.getRange(35, 42).toList(),
        ),
      ],
    );
  }
}

const List<String> _DaysOfTheWeek = ['日', '月', '火', '水', '木', '金', '土'];

/// 曜日のラベルを横並びに表示する。
class DaysOfTheWeek extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: _DaysOfTheWeek.map((day) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// 1列で1週間を表すため、[DateCell]を7つ並べる。
class DatesRow extends HookConsumerWidget {
  const DatesRow({
    required this.dates,
    Key? key,
  }) : super(key: key);

  final List<DateTime> dates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return _DateCell(date);
        }).toList(),
      ),
    );
  }
}

class _DateCell extends HookConsumerWidget {
  _DateCell(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
            right: BorderSide(color: Theme.of(context).dividerColor, width: 1),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await showModalBottomSheet(
                context: context,
                builder: (context) => DraggableScrollableSheet(
                      //これ！
                      initialChildSize: 1,
                      builder: (BuildContext context,
                              ScrollController scrollController) =>
                          Container(
                        child: Column(children: [
                          IconButton(
                            icon: Icon(Icons.expand_more_outlined),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children:
                                  ["a", "b", "c", "a", "b", "c", "a", "b", "c"]
                                      .map((e) => ListTile(
                                            title: Text(
                                              e,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            onTap: () {
                                              //Navigator.of(context).pop();
                                            },
                                          ))
                                      .toList(),
                            ),
                          )
                        ]),
                      ),
                    ));
          },
          child: Column(
            children: [
              Text(date.day.toString()),
              for (int i = 0;
                  i < ref.watch(calenderListProvider).length;
                  i++) ...{
                ifText(
                    (date.day == ref.watch(calenderListProvider)[i].targetDate.day &&
                        date.month == ref.watch(calenderListProvider)[i].targetDate.month &&
                        date.year == ref.watch(calenderListProvider)[i].targetDate.year),
                    ref.watch(calenderListProvider)[i])
              },
              Spacer(),
              for (int i = 0;
              i < ref.watch(calenderListProvider).length;
              i++) ...{
                TaskRow(
                    (date.day == ref.watch(calenderListProvider)[i].targetDate.day &&
                        date.month == ref.watch(calenderListProvider)[i].targetDate.month &&
                        date.year == ref.watch(calenderListProvider)[i].targetDate.year),
                    ref.watch(calenderListProvider)[i])
              },
            ],
          ),
        ),
      ),
    );
  }
}

Widget ifText(bool value, CalenderCell cell) {
  if (value) {
    return Column(
      children: [
        //Text(date.year.toString() + date.day.toString()),

        for (int i = 0; i < cell.eventList.length; i++) ...{
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Container(
              width: double.infinity,
              height: 12,
              color: Colors.red,
              child: Text(cell.eventList[i].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 9),
                  overflow: TextOverflow.ellipsis),
            ),
          )
        }
      ],
    );
  } else {
    return Column(
      children: [],
    );
  }
}
Widget TaskRow(bool value, CalenderCell cell) {
  if (value) {
    return Row(
      children: [
        //Text(date.year.toString() + date.day.toString()),

        for (int i = 0; i < cell.todoList.length; i++) ...{
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Icon(Icons.circle,size: 12,)
          )
        }
      ],
    );
  } else {
    return SizedBox.shrink();
  }
}

Widget ifText2(bool value) {
  if (value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        color: Colors.red,
        child: Text(
          "test",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
        ),
      ),
    );
  } else {
    return const Text("b");
  }
}

extension DateExtension on int {
  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }

  String get monthName {
    final monthNameList = [
      "1月",
      "2月",
      "3月",
      "4月",
      "5月",
      "6月",
      "7月",
      "8月",
      "9月",
      "10月",
      "11月",
      "12月"
    ];
    return monthNameList[this - 1];
  }

  DateTime get visibleDateTime {
    final monthDif = this - 1200;
    final visibleYear = _visibleYear(monthDif);
    final visibleMonth = _visibleMonth(monthDif);
    return DateTime(visibleYear, visibleMonth);
  }

  int _visibleYear(int monthDif) {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    final visibleMonth = currentMonth + monthDif;

    /// visibleMonthの表している月が
    /// 今年、もしくは来年以降の場合
    if (visibleMonth > 0) {
      return currentYear + (visibleMonth ~/ 12);

      /// visibleMonthが去年以前の場合
    } else {
      return currentYear + ((visibleMonth ~/ 12) - 1);
    }
  }

  int _visibleMonth(int monthDif) {
    final initialMonth = DateTime.now().month;
    final currentMonth = initialMonth + monthDif;

    /// visibleMonthの表している月が
    /// 今年、もしくは来年以降の場合
    if (currentMonth > 0) {
      return currentMonth % 12;

      /// visibleMonthが去年以前の場合
    } else {
      return 12 - (-currentMonth % 12);
    }
  }
}
