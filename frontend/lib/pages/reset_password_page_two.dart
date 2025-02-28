import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ResetPasswordPageTwo extends StatefulWidget {
  const ResetPasswordPageTwo({super.key});

  @override
  State<ResetPasswordPageTwo> createState() => _ResetPasswordPageTwoState();
}

class _ResetPasswordPageTwoState extends State<ResetPasswordPageTwo> {
  String pErrMsg = "";

  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Reset Password'),
      body: Padding(
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
                btn("Next", false, () => next(context, '/resetPasswordThree')),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}