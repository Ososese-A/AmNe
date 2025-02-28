import 'package:flutter/material.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/components/key_pad.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ForgotPasswordPageOne extends StatefulWidget {
  const ForgotPasswordPageOne({super.key});

  @override
  State<ForgotPasswordPageOne> createState() => _ForgotPasswordPageOneState();
}

class _ForgotPasswordPageOneState extends State<ForgotPasswordPageOne> {
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
    if (dot_count == 6) {
      //compare with code generated from backend and sent to user as email
      //also don't forget to handle errors

      //dummy test to stand in for db test
      var userPin = '123456';
      print('This is userpin: $userPin');
      print('This is user dotString: $dotString');
      if (userPin == dotString) {
        setMainPage(context, '/forgotPasswordTwo', '/forgotPasswordOne');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    width: 316.0,
                    child: Text(
                      "Please enter the 6 digit code that was sent to your inbox", 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: customColors.app_white, fontSize: 16.0),
                    )
                  ),
                  Container(
                    width: 256.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dot_count >= 1 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 2 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 3 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 4 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count >= 5 ? pin_dot(active:  true) : pin_dot(active:  false),
                        dot_count == 6 ? pin_dot(active:  true) : pin_dot(active:  false),
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
              forgot: true,
            )
          ],
        ),
      )
    );
  }
}