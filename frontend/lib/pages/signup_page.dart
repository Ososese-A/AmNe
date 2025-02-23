import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/google_btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/cryptUtility.dart';
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
    print('Post encryption decrypted Password: ${dePData}');


    try {
      var res = await Dio().post(
        'http://192.168.31.190:8080/api/signup/',
        data: {
          // "email": enEData,
          // "password": enPData
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
      print('Error: ${e.response?.data}');

      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        setState(() {
          eErrMsg = e.response?.data['error'];
        });
      } else {
        final errorMsg = e.response?.data;

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
        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Or Sign Up with:",
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