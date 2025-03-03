import 'package:flutter/material.dart';
import 'package:frontend/add_ons/alt_app_bar.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/components/key_pad.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({super.key});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  int dot_count = 0;
  String pError = "";
  bool isLoading = false;

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


  @override
  Widget build(BuildContext context) {
    // Map nextPageInfo = ModalRoute.of(context)!.settings.arguments as Map ?? {};
    Map? nextPageInfo = ModalRoute.of(context)?.settings.arguments as Map?;

    if (nextPageInfo == null) {
      print("Message from enter pin; it is empty");
    } else {
      print("Message from enter pin; it is NOT empty");
      print(nextPageInfo);
    }

  void _getDotString (dotString) async {
    print("The dot String: $dotString");
    dotString = encrypt(dotString);
    if (dot_count == 4) {
      setState(() {
        isLoading = true;
      });
      //compare with pin in db and confirm session json token
      //also don't forget to handle errors
      final backendResponse = await dotsAuth(dotString: dotString, ctx: context, type: 'confirmDots');

      //dummy test to stand in for db test
      // var p = getP();
      // var userPin = decrypt(p);
      // print('This is userpin: $userPin');
      // if (userPin == dotString) {
      setState(() {
        isLoading = false;
      });
      
      if (backendResponse['isThereError']) {
        setState(() {
          pError = backendResponse['pError'];
        });
      } else {
        if (nextPageInfo?['retainAppBar'] != null && nextPageInfo?['retainAppBar'] == true) {
          pop_up(
            ctx: context,
            txt: 'Your account is currently under review, as such you will not be able to make any transactions',
            minor: false,
            primaryBtn: true,
            primaryBtnTxt: 'Done',
            primaryBtnOnTap: () => setMainPage(context, '/main', '/main'),
          );
        } else {
          nextPageInfo == null ? setMainPage(context, '/main', '/main') : next(context, nextPageInfo['nextPage']);
        }
      }
    }
  }



    return Scaffold(
      appBar: nextPageInfo == null ? alt_app_bar(page: "Enter Pin", isLoading: isLoading) : nextPageInfo['retainAppBar'] != null ? alt_app_bar(page: "Enter Pin") : app_bar(context, nextPageInfo['pageName']),
      backgroundColor: customColors.app_black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
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
          
                  SizedBox(height: 40.0,),
          
                  KeyPad(
                    set: _setDotCount,
                    reset: _resetDotCount,
                    get: _getDotString,
                  )
                ],
              ),
            ),
          ),


          if (isLoading)
          loading_spinner()
        ],
      )
    );
  }
}
