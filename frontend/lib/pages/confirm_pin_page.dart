import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/components/key_pad.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ConfirmPinPage extends StatefulWidget {
  const ConfirmPinPage({super.key});

  @override
  State<ConfirmPinPage> createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  int dot_count = 0;
  String pError = "";


  void _setDotCount (count) {
    setState(() {
      dot_count = count;
      pError = "";
    });
  }

  void _resetDotCount (count) {
    setState(() {
      dot_count = count;
    });
  }

  void _getDotString (dotString) {
    print("The dot String: $dotString");
    if (dot_count == 4) {
      _setPin(dotString);
    }
  }

  void _setPin (dotString) {
    print("From set pin $dotString");
    String cPin = encrypt(dotString);
    print("encrypted cPin ${cPin}");
    String pin = getP();
    print("encrypted pin from box ${getP()}");
    if ( cPin == pin) {
      setState(() {
        dot_count = 0;
        pError = "";
      });
    } else {
      setState(() {
        dot_count = 0;
        pError = "The pin you entered doesn't match the pin you set";
      });
    }
    _assignPin(cPin);
    setMainPage(context, "/main", "/main");
  }

  void _assignPin (cPin) async {
    String j = getJ();
    String u = getU();

    final String dePData =  decrypt(cPin);
    print('Post encryption decrypted Password: ${dePData}');
    print('This is the user $u');
    print('This is the json $j');


    try {
      var res = await Dio().post(
        'http://192.168.31.190:8080/api/signup/assignPin',
        data: {
          // "email": enEData,
          // "password": enPData
          "pin": cPin,
          "id": u
        },
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
        },
      ),
      );

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');
      final _uId = result['id'];
      print('User: ${_uId}');

      setState(() {
        pError = "";
      });

      if (result['id'] != null) {
        setU(_uId);
        print('The setup works');
        // nextPage(context, '/pin');
      }
    } on DioException catch (e) {
      print('Error: ${e.response?.data}');

      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {}
        setState(() {
          pError = 'Account does not exist';
        });
      } else {
        final errorMsg = e.response?.data;

          List <String> pinErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'pin') {
              pinErrors.add(error['msg']);
            }
          }

          if (pinErrors != []) {
              String pinErrorDisplay = pinErrors.join('\n');
              print('Email Error: $pinErrorDisplay');
              setState(() {
                pError = pinErrorDisplay;
              });
          } else {
              final defaultError = "An Unknown Error Occured, Please try again";
              setState(() {
                pError = defaultError;
              });
          }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Confirm Pin"),
      backgroundColor: customColors.app_black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 160.0,
              width: 320.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Please confirm the pin you just set", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                  Container(
                    width: 120.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dot_count >= 1 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 2 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 3 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count == 4 ? pin_dot(active:  true) : pin_dot(active:  false),
                      ],
                    ),
                  ),
                  Text(
                    pError, 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: customColors.app_red, 
                      fontSize: 16.0
                    ),
                  ),
                ],
              ),
            ),
            KeyPad(
              set: _setDotCount,
              reset: _resetDotCount,
              get: _getDotString,
            )
          ],
        ),
      )
    );
  }
}