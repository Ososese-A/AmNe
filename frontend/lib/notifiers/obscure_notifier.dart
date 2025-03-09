import 'package:flutter/material.dart';

class ObscureNotifier extends ChangeNotifier {
  bool _obscure = true;

  bool get obscure => _obscure;

  void setObscureValue(bool newObscureValue) {
    _obscure = newObscureValue;
    notifyListeners();
  }
}