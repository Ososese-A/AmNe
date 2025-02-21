import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class IntroSlide2 extends StatelessWidget {
  const IntroSlide2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Easy & Secure\n Transactions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              color: customColors.app_white
            ),
          ),
          // SizedBox(height: 8.0),
          svg_box(260, 320, "assets/images/vault_a.svg"),
          // SizedBox(height: 8.0),
          Text(
            "Secure transactions and \n real-time data with Amne.",
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