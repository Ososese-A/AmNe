import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/components/key_pad.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ResetPinPageTwo extends StatefulWidget {
  const ResetPinPageTwo({super.key});

  @override
  State<ResetPinPageTwo> createState() => _ResetPinPageTwoState();
}

class _ResetPinPageTwoState extends State<ResetPinPageTwo> {
    int dot_count = 0;
  String j = "";
  String u = "";
  String pError = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    j = getJ();
    u = getU();

    print(j.runtimeType);
    print(u.runtimeType);
  }

  void _setDotCount (count) {
    setState(() {
      dot_count = count;
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
    setP(encrypt(dotString));
    print("encrypted pin from box ${getP()}");
    setState(() {
      dot_count = 0;
    });
    next(context, "/resetPinThree");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, 'Reset Pin'),
      backgroundColor: customColors.app_black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Please Enter the new pin you wish to set", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
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
                    Text(pError, style: TextStyle(color: customColors.app_red, fontSize: 16.0),),
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
        ),
      )
    );
  }
}