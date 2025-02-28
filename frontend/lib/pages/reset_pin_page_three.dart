import 'package:flutter/material.dart';
import 'package:frontend/add_ons/alt_app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/components/key_pad.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ResetPinPageThree extends StatefulWidget {
  const ResetPinPageThree({super.key});

  @override
  State<ResetPinPageThree> createState() => _ResetPinPageThreeState();
}

class _ResetPinPageThreeState extends State<ResetPinPageThree> {
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

    pop_up(
      ctx: context,
      txt: 'Pin reset Successful',
      minor: false,
      primaryBtn: true,
      primaryBtnTxt: 'Done',
      primaryBtnOnTap: () => setMainPageWithData(context, '/main', '/main', 2),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: alt_app_bar('Confirm New Pin'),
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