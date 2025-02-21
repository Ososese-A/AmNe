import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

MaterialButton google_btn (onTap) { 
  return MaterialButton(
    onPressed: onTap,
    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Sign Up With Google",
          style: TextStyle(
            fontSize: 16.0,
            letterSpacing: 2.0,
          ),
        ),

        svg_box(32.0, 32.0, "assets/icons/google.svg")
      ],
    ),
    minWidth: 210.0,
    height: 50.0,
    color:Colors.transparent,
    textColor: customColors.app_light_a,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(
        color: customColors.app_light_a,
        width: 1.0
      )
    ),
  );
}