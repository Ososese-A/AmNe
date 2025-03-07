import 'package:flutter/material.dart';

class CurrencyNotifier extends ChangeNotifier {
  String _currency = 'NGN';

  String get currency => _currency;

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }
}