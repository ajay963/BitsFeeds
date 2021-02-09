import 'package:flutter/material.dart';

class CustomNavBar with ChangeNotifier {
  int selectedIndex = 0;
  double iconSize = 40;
  double itemsSpacing = 14;
  double deviceWidth;
  double xPosition = -1.0;
  double widthPadding;
  String itemState0 = "Active";
  String itemState1 = "Active";
  String itemState2 = "Active";

  itemsAssign(int assignedIndex) {
    selectedIndex = assignedIndex;
    switch (assignedIndex) {
      case 0:
        selectedItem0();
        break;
      case 1:
        selectedItem1();
        break;
      case 2:
        selectedItem2();
        break;

      default:
        selectedItem0();
        break;
    }

    notifyListeners();
  }

  selectedItem0() {
    print('items selected 0');

    itemState0 = (itemState0 != "Active") ? "Active" : "Ae";
    xPosition = -1.0;
    itemState1 = 'Ae';
    itemState2 = 'Ae';
    selectedIndex = 0;
    notifyListeners();
  }

  selectedItem1() {
    print('items selected 1');

    itemState1 = (itemState1 != "Active") ? "Active" : "Ae";
    xPosition = 0;
    selectedIndex = 1;
    itemState0 = 'Ae';
    itemState2 = 'Ae';
    notifyListeners();
  }

  selectedItem2() {
    itemState2 = (itemState2 != "Active") ? "Active" : "Ae";

    itemState2 = "Active";
    xPosition = 1.0;
    selectedIndex = 2;
    itemState0 = 'Ae';
    itemState1 = 'Ae';
    notifyListeners();
  }
}
