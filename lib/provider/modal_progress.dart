import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier {
  bool isLoading = false;

  changeIsloading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
