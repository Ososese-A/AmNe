import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ForgotPasswordPageTwo extends StatefulWidget {
  const ForgotPasswordPageTwo({super.key});

  @override
  State<ForgotPasswordPageTwo> createState() => _ForgotPasswordPageTwoState();
}

class _ForgotPasswordPageTwoState extends State<ForgotPasswordPageTwo> {
  final String securityAnswerErr = '';
  final TextEditingController securityAnswerController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 112.0,),
            Container(
              width: 312.0,
              child: Text(
                'Security Question',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: customColors.app_white
                ),
              ),
            ),

            SizedBox(height: 40.0,),

            Container(
              child: Column(
                children: [
                  Text(
                    'Who is the smartest person you know?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: customColors.app_white
                    ),
                  ),

                  SizedBox(height: 16.0,),

                  InputField(
                    placeholder: 'Security Answer e.g; Rampo', 
                    iconPath: 'assets/icons/password.svg', 
                    type: 'normal', 
                    error: securityAnswerErr, 
                    fieldHeight: 140.0, 
                    errorHeight: 40.0, 
                    controller: securityAnswerController
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btn("Next", false, () => nextWithData(context, '/epin', {
                  'nextPage': '/resetPinTwo',
                  'pageName': 'Reset Pin',
                  'retainAppBar' : true
                })),
              ],
            )
          ],
        ),
      ),
    );
  }
}