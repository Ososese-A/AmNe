import 'package:flutter/material.dart';

class Walletmodel extends ChangeNotifier {
  double _balance = 0;
  double _balanceInNaira = 0;
  double _balanceInDollars = 0;
  double _rate = 0;
  double _etnValue = 0;
  String _address = '';

  double get balance => _balance;
  double get balanceInNaira=> _balanceInNaira * _balance;
  double get balanceInDollars => _balanceInDollars * _balance;
  double get rate => _rate;
  double get etnValue => _etnValue;
  String get address => _address;

  void updateWalletInfo({required String newAddress, required double newBalance, required double newBalanceInNaira, required double newBalanceInDollars, required double newRate, required double newEtenValue}) {
    _balance = newBalance;
    _balanceInNaira = newBalanceInNaira;
    _balanceInDollars = newBalanceInDollars;
    _address = newAddress;
    _rate = newRate;
    _etnValue = newEtenValue;
    print("This is the new wallet balance form wallet model $balance");
    print("This is the new naira balance form wallet model $balanceInNaira");
    print("This is the new dollars balance form wallet model $balanceInDollars");
    notifyListeners();
  }
}