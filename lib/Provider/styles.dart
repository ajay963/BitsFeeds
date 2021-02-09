import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Styles with ChangeNotifier {
  double imageSize = 70;
  bool isActionButton = false;
  setActionButtonState({bool getState}) {
    isActionButton = getState;
    notifyListeners();
  }

  setActionByIdType({User userid}) {}

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
