import 'package:flutter/material.dart';

class Walletmodel extends ChangeNotifier {
  double _balance = 0;
  String _address = '';

  double get balance => _balance;
  String get address => _address;

  void updateWalletInfo(double newBalance, String newAddress) {
    _balance = newBalance;
    _address = newAddress;
    notifyListeners();
  }
}