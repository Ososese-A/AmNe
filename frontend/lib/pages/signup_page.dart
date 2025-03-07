import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/google_btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String eErrMsg = "";
  String pErrMsg = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signup () async {
    String eData = emailController.text;
    String pData = passwordController.text;

    if (eData == '' || pData == '') {
      setState(() {
        eErrMsg = eData == '' ? 'Please enter your email address' : '';
        pErrMsg = pData == '' ? 'Please set a password' : '';
      });
    }  else {
      final backendResponse = await authenticate(eData: eData, pData: pData, ctx: context, type: 'signup');
      print(backendResponse);
      if (backendResponse['isThereError']) {
        setState(() {
          eErrMsg = backendResponse['eErrMsg'];
          pErrMsg = backendResponse['pErrMsg'];
        });
      } else {
        setMainPage(context, '/pin', '/pin');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Sign Up"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              SizedBox(height: 56.0,),

              InputField(
                placeholder: "Email Address", 
                iconPath: "assets/icons/mail.svg", 
                type:  "normal",
                error: eErrMsg != "" ? eErrMsg : "",
                fieldHeight: 140.0,
                errorHeight: 40.0,
                controller: emailController,
              ),

          
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
                    btn("Sign Up", false, _signup),
                  ],
                ),
              ),
        
              SizedBox(height: 120.0),
        
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Or Sign Up with:",
              //       style: TextStyle(
              //         color: customColors.app_white,
              //         fontSize: 20.0
              //       ),
              //     ),
        
              //     SizedBox(height: 28.0,),
        
              //     google_btn(() {})
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}