import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:pro_sche/view/ui/toggle_switch_button.dart';

import 'main.dart';

class FolderPage extends ConsumerWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ToggleSwitchButton()

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ref.read(countProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}