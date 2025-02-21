import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class IntroSlide3 extends StatelessWidget {
  const IntroSlide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Empower Your\n Investments",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              color: customColors.app_white
            ),
          ),
          SizedBox(height: 16.0),
          svg_box(240, 280, "assets/images/launch_a.svg"),
          SizedBox(height: 16.0),
          Text(
            "Maximize your \n Investments with Amne.",
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