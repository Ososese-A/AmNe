import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/google_btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/crypt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errMsg = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login () {
    final String key = '108afFbB90cC34e6';
    final String initVector = 'abcdefghijklmnop';

    final String eData = emailController.text;
    final String pData = passwordController.text;
    print('Pre encryption Email: ${eData}');
    print('Pre encryption Password: ${pData}');

    final Uint8List enPData = encrypt(pData, key, initVector);
    final Uint8List enEData = encrypt(eData, key, initVector);

    final String deEData =  decrypt(enEData, key, initVector);
    print('Post encryption Email: ${enEData}');
    print('Post encryption decrypted Email: ${deEData}');
    print('Post encryption Password: ${enPData}');
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
                error: errMsg != "" ? errMsg : "",
                controller: emailController,
              ),
          
              InputField(
                placeholder: "Password", 
                iconPath: "assets/icons/password.svg", 
                type:  "password",
                error: errMsg != "" ? errMsg : "",
                controller: passwordController,
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