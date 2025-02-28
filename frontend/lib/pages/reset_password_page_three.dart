import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ResetPasswordPageThree extends StatefulWidget {
  const ResetPasswordPageThree({super.key});

  @override
  State<ResetPasswordPageThree> createState() => _ResetPasswordPageThreeState();
}

class _ResetPasswordPageThreeState extends State<ResetPasswordPageThree> {
  String pErrMsg = "";
  String cpErrMsg = "";

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


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
            placeholder: "Set New Password", 
            iconPath: "assets/icons/password.svg", 
            type:  "password",
            error: pErrMsg != "" ? pErrMsg : "",
            fieldHeight: 140.0,
            errorHeight: 40.0,
            controller: passwordController,
          ),
            InputField(
            placeholder: "Confirm New Password", 
            iconPath: "assets/icons/password.svg", 
            type:  "password",
            error: cpErrMsg != "" ? cpErrMsg : "",
            fieldHeight: 220.0,
            errorHeight: 120.0,
            controller: confirmPasswordController,
          ),
          
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                    btn("Done", false, () => pop_up(
                    ctx: context,
                    txt: 'Password reset Successful',
                    minor: false,
                    primaryBtn: true,
                    primaryBtnTxt: 'Done',
                    primaryBtnOnTap: () => setMainPageWithData(context, '/main', '/main', 2),
                  )
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}