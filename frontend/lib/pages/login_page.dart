import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/google_btn.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void _login () async {
    final String eData = emailController.text;
    final String pData = passwordController.text;
    print('Pre encryption Email: ${eData}');
    print('Pre encryption Password: ${pData}');

    final String enPData = encrypt(pData);
    final String enEData = encrypt(eData);

    final String deEData =  decrypt(enEData);
    final String dePData =  decrypt(enPData);
    print('Post encryption Email: ${enEData}');
    print('Post encryption decrypted Email: ${deEData}');
    print('Post encryption Password: ${enPData}');
    print('Post encryption decrypted Email: ${dePData}');

    try {
      var res = await Dio().post(
        // 'http://192.168.31.190:8080/api/login/',
        'http://10.101.76.99:8080/api/login/',
        data: {
          "email": enEData,
          "password": enPData
        }
      );

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');
      final _uId = result['id'];
      final _jId = result['token'];
      print('User: ${_uId}');
      print('Json: ${_jId}');

      setState(() {
        eErrMsg = "";
        pErrMsg = "";
      });

      

      if (result['id'] != null) {
        setU(_uId);
        setJ(_jId);
        print('The setup works');
        nextPage(context, '/pin');
      }

    } on DioException catch (e) {
      final errorMsg = e.response?.data;
      // print('Error: ${e.response?.data}');
      // print("This is the type ${errorMsg.runtimeType}");
      // print("This is the type ${errorMsg['error'].runtimeType}");

      if (errorMsg['error'] != null) {
        final error = jsonDecode(errorMsg['error']);
        print(error);
        print(error['pError']);
        if (error['eError'] != null) {
          setState(() {
            eErrMsg = error['eError'];
            pErrMsg = "";
          });
        } else if (error['pError'] != null) {
          setState(() {
            pErrMsg = error['pError'];
            eErrMsg = "";
          });
        } else {
          final defaultError = "An Unknown Error Occured, Please try again";
          setState(() {
            eErrMsg = defaultError;
            pErrMsg = "";
          });
        }
        //chek if there is perror then check if there is eerror
      } else {
          List <String> emailErrors = [];
          List <String> passwordErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'email') {
              emailErrors.add(error['msg']);
            } else if (error['path'] == 'password') {
              passwordErrors.add(error['msg']);
            }
          }

          if (emailErrors != [] && passwordErrors == []) {
              String emailErrorDisplay = emailErrors.join('\n');
              print('Email Error: $emailErrorDisplay');
              setState(() {
                eErrMsg = emailErrorDisplay;
                pErrMsg = "";
              });
          } else if (emailErrors == [] && passwordErrors != []) {
              String passwordErrorDisplay = passwordErrors.join('\n');
              print('Password Error: $passwordErrorDisplay');
              setState(() {
                pErrMsg = passwordErrorDisplay;
                eErrMsg = "";
              });
          } else if (emailErrors != [] && passwordErrors != []) {
              String emailErrorDisplay = emailErrors.join('\n');
              String passwordErrorDisplay = passwordErrors.join('\n');
              print('Email Error: $emailErrorDisplay');
              print('Password Error: $passwordErrorDisplay');
              setState(() {
                  eErrMsg = emailErrorDisplay;
                  pErrMsg = passwordErrorDisplay;
                });
          } else {
              final defaultError = "An Unknown Error Occured, Please try again";
              setState(() {
                eErrMsg = defaultError;
                pErrMsg = "";
              });
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Login"),
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

              SizedBox(height: 20.0,),
          
              InputField(
                placeholder: "Password", 
                iconPath: "assets/icons/password.svg", 
                type:  "password",
                error: pErrMsg != "" ? pErrMsg : "",
                fieldHeight: 240.0,
                errorHeight: 120.0,
                controller: passwordController,
                forgotPassword: true,
                forgotPasswordAction: () => pop_up(
                  ctx: context,
                  txt: 'We sent an email to you inbox please confirm if you have received the email.',
                  minor: false,
                  primaryBtn: true,
                  primaryBtnTxt: 'Confirm',
                  primaryBtnOnTap: () => next(context, '/forgotPasswordOne'),
                  secondaryBtn: true,
                  secondaryBtnTxt: 'Cancel',
                  secondaryBtnOnTap: () {}
                ),
              ),
        
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btn("Login", false, _login),
                  ],
                ),
              ),
        
              SizedBox(height: 120.0),
        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Or Login with:",
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
        
                  SizedBox(height: 28.0,),
        
                  google_btn(() {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}