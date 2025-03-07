import 'package:flutter/material.dart';

class isAccountSetUpNotifier extends ChangeNotifier {
  bool _isAccountSetUp = false;

  bool get isAccountSetUp => _isAccountSetUp;

  void setAccountSetUpState(bool newisAccountSetUp) {
    _isAccountSetUp = newisAccountSetUp;
    notifyListeners();
  }
}