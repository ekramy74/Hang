import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;
  changeIsAdmin(value) {
    isAdmin = value;
    notifyListeners();
  }
}
