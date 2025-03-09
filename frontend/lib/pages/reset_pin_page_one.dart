import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class ResetPinPageOne extends StatefulWidget {
  const ResetPinPageOne({super.key});

  @override
  State<ResetPinPageOne> createState() => _ResetPinPageOneState();
}

class _ResetPinPageOneState extends State<ResetPinPageOne> {
  String securityAnswerErr = '';
  TextEditingController securityAnswerController = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    final securityQuestion = decrypt(decrypt(Provider.of<Accountmodel>(context).quest));


    void _confirm () async {
    setState(() {
      isLoading = true;
    });


    String sQData = securityQuestion;
    String sAData = securityAnswerController.text.toLowerCase();

    if (sAData == '') {
      setState(() {
        securityAnswerErr = 'Please set an answer to your security question';
      });

      setState(() {
        isLoading = false;
      });
    } else {
      final backendResponse = await confirmAccountSecurityAuth(securityQuestion: sQData, securityAnswer: sAData, type: 'setup');
      setState(() {
        isLoading = false;
      });
      if (backendResponse['isThereError']) {
        setState(() {
          securityAnswerErr = backendResponse['securityAnswerErr'];
        });
      } else {
        nextWithData(context, '/epin', {
          'nextPage': '/resetPinTwo',
          'pageName': 'Reset Pin'
        });
      }
    }
  }


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Reset Pin"),
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
