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

  void updateWalletInfo({
    required String newAddress, 
    required double newBalance, 
    required double newBalanceInNaira, 
    required double newBalanceInDollars, 
    required double newRate, 
    required double newEtenValue
  }) {
    _balance = newBalance;
    _balanceInNaira = newBalanceInNaira;
    _balanceInDollars = newBalanceInDollars;
    _address = newAddress;
    _rate = newRate;
    _etnValue = newEtenValue;
    notifyListeners();
  }
}
















class Accountmodel extends ChangeNotifier {
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _mobile = "";
  String _address = "";
  String _quest = "";

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get mobile => _mobile;
  String get address => _address;
  String get quest => _quest;

  void updateAccountInfo({
    required String newFirstName, 
    required String newLastName,
    required String newEmail,
    required String newMobile,
    required String newAddress,
    required String newQuest,
  }) {
    _address = newAddress;
    _email = newEmail;
    _firstName = newFirstName;
    _lastName = newLastName;
    _mobile = newMobile;
    _quest = newQuest;

    notifyListeners();
  }
}