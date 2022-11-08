import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'calender.dart';
import 'folder_view.dart';
import 'main.dart';

class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: Center(
        child: CalendarPageView()
      )
    );
  }
}