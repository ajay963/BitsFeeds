import 'package:flutter/foundation.dart';

class EventNav extends ChangeNotifier {
  int eventCurrentPage = 0;
  setEventPAge({@required int setPageNo}) {
    eventCurrentPage = setPageNo;
    notifyListeners();
  }
}
