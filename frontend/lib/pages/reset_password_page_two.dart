import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class ResetPasswordPageTwo extends StatefulWidget {
  const ResetPasswordPageTwo({super.key});

  @override
  State<ResetPasswordPageTwo> createState() => _ResetPasswordPageTwoState();
}

class _ResetPasswordPageTwoState extends State<ResetPasswordPageTwo> {
  String pErrMsg = "";
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  void _proceed () async {
    setState(() {
      isLoading = true;
    });

    final String eData = Provider.of<Accountmodel>(context, listen: false).email;
    final String pData = passwordController.text;
    
    if (eData == '' || pData == '') {
      setState(() {
        pErrMsg = pData == '' ? 'Please set a password' : '';
      });
    }  else {
      final backendResponse = await authenticate(eData: eData, pData: pData, ctx: context, type: 'passwordCheck');
      print(backendResponse);
      if (backendResponse['isThereError']) {
        setState(() {
          pErrMsg = backendResponse['pErrMsg'];
        });
      } else {
        next(context, '/resetPasswordThree');
      }
    }

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Reset Password'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 28.0,),
                  Text(
                    'Please enter your password',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                  ),
                  SizedBox(height: 96.0,),
                  InputField(
                  placeholder: "Password", 
                  iconPath: "assets/icons/password.svg", 
                  type:  "password",
                  error: pErrMsg != "" ? pErrMsg : "",
                  fieldHeight: 220.0,
                  errorHeight: 120.0,
                  controller: passwordController,
                ),
                
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      btn("Next", false, () => _proceed()),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),


          if(isLoading)
          loading_spinner()
        ],
      ),
    );
  }
}