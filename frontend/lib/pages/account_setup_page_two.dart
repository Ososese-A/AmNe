import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class AccountSetupPageTwo extends StatefulWidget {
  const AccountSetupPageTwo({super.key});

  @override
  State<AccountSetupPageTwo> createState() => _AccountSetupPageTwoState();
}

class _AccountSetupPageTwoState extends State<AccountSetupPageTwo> {
  String securityQuestionErr = '';
  TextEditingController securityQuestionController = TextEditingController();

  String securityAnswerErr = '';
  TextEditingController securityAnswerController = TextEditingController();

  void _secure () async {
    String sQData = securityQuestionController.text;
    String sAData = securityAnswerController.text;

    if (sQData == '' || sAData == '') {
      setState(() {
        securityQuestionErr = sQData == '' ? 'Please set a security question' : '';
        securityAnswerErr = sAData == '' ? 'Please set an answer to your security question' : '';
      });
    } else {
      final backendResponse = await accountSecurityAuth(securityQuestion: sQData, securityAnswer: sAData, type: 'setup');
      if (backendResponse['isThereError']) {
        setState(() {
          securityAnswerErr = backendResponse['securityAnswerErr'];
          securityQuestionErr = backendResponse['securityQuestionErr'];
        });
      } else {
        nextWithData(context, '/accountSetupThree', {'securityQuestion': sQData});
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Account Setup"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
            Container(
              width: 312.0,
              child: Text(
                'Please set a security question \n(Your security question and answer should be some thing only you know that is easy to remeber)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: customColors.app_white
                ),
              ),
            ),

            SizedBox(height: 40.0,),

            InputField(
              placeholder: 'Security Question e.g; Who is the smartest person you know?', 
              iconPath: 'assets/icons/password.svg', 
              type: 'address', 
              error: securityQuestionErr, 
              fieldHeight: 180.0, 
              errorHeight: 40.0, 
              controller: securityQuestionController
            ),

            InputField(
              placeholder: 'Security Answer e.g; Rampo', 
              iconPath: 'assets/icons/password.svg', 
              type: 'normal', 
              error: securityAnswerErr, 
              fieldHeight: 140.0, 
              errorHeight: 40.0, 
              controller: securityAnswerController
            ),

            SizedBox(height: 40.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btn("Next", false, () => _secure()),
              ],
            )
          ],
        ),
      ),
    );
  }
}