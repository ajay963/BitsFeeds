import 'package:flutter/material.dart';

class CustomStyles with ChangeNotifier {
  double imageSize = 76;

  final InputDecoration inputFieldDecoration = InputDecoration(
    labelText: 'E-mail',
    labelStyle: TextStyle(
        fontSize: 24, color: Color(0xff666666), fontWeight: FontWeight.bold),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: Color(0xffCCCCCC), style: BorderStyle.solid),
    ),
  );
}
