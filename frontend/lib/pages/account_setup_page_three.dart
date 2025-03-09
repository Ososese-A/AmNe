import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class AccountSetupPageThree extends StatefulWidget {
  const AccountSetupPageThree({super.key});

  @override
  State<AccountSetupPageThree> createState() => _AccountSetupPageThreeState();
}


class _AccountSetupPageThreeState extends State<AccountSetupPageThree> {
  String securityAnswerErr = '';
  TextEditingController securityAnswerController = TextEditingController();
  String securityQuestion = '';
  bool isLoading = false;


  void _confirm () async {
    String sQData = securityQuestion;
    String sAData = securityAnswerController.text.toLowerCase();

    if (sAData == '') {
      setState(() {
        securityAnswerErr = 'Please set an answer to your security question';
      });
    } else {
      final backendResponse = await confirmAccountSecurityAuth(securityQuestion: sQData, securityAnswer: sAData, type: 'setup');
      if (backendResponse['isThereError']) {
        setState(() {
          securityAnswerErr = backendResponse['securityAnswerErr'];
        });
      } else {
        next(context, '/kycUpload');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> securityQuest = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    securityQuestion = securityQuest['securityQuestion'];


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Account Setup"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                SizedBox(height: 28.0,),
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
                        securityQuestion,
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
                    // btn("Next", false, () => next(context, '/kycUpload')),
                    btn("Next", false, () => _confirm()),
                  ],
                )
              ],
            ),
          ),


          if(isLoading)
          loading_spinner()
        ],
      ),
    );
  }
}