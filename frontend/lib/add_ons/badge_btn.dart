import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

GestureDetector badge_btn (String text, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
              fontSize: 14.0
            ),
          ),
        ),
    ),
  );
}