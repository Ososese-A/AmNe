import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _signUp () {
      // print("Sign up");
      Navigator.pushNamed(context, '/signup');
    }

    void _login () {
      // print("Login");
      Navigator.pushNamed(context, '/login');
    }

    return Scaffold(
      backgroundColor: customColors.app_black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svg_box(338.0, 290.0, "assets/images/auth_a.svg"),

          SizedBox(height: 80.0,),

          Center(
            child: Container(
              width: 210.0,
              height: 140.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn("Sign Up", false, _signUp),
                  btn("Login", true, _login),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}