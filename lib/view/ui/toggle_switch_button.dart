import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // （1） ON/OFFの初期値定義
    final isSelected = [true, false, false];
    return ToggleButtons(
      // （2） ON/OFFの指定
      isSelected: isSelected,
      // （3） ボタンが押されたときの処理
      onPressed: (index){},
      // （4） 各ボタン表示の子ウィジェットの指定
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Button 1'),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Button 2'),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Button 3'),
        ),
      ],
    );
  }
}