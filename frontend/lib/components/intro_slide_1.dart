import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class IntroSlide1 extends StatelessWidget {
  const IntroSlide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Amne",
            style: TextStyle(
              fontSize: 24.0,
              color: customColors.app_white
            ),
          ),
          SizedBox(height: 16.0),
          svg_box(280, 280, "assets/images/welcome_a.svg"),
          SizedBox(height: 16.0),
          Text(
            "Buy and sell stocks with \n Electroneum using Amne.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: customColors.app_white
            ),
          )
        ],
      ),
    );
  }
}