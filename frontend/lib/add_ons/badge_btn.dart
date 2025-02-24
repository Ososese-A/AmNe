import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Container badge_btn (String text) {
  return Container(
    height: 40.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: customColors.app_dark_a,
      borderRadius: BorderRadius.circular(8.0)
    ),
    child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: customColors.app_white,
            fontSize: 16.0
          ),
        ),
      ),
  );
}