import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_sche/base_tab_view.dart';


void main() {
  runApp(const ProviderScope(child: MainView()));
}

class MainView extends StatelessWidget {
  const MainView({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: BaseTabView(),
    );
  }
}