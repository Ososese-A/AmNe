import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

MaterialButton btn (String txt, bool type, onTap) { 
  return MaterialButton(
    onPressed: onTap,
    child: Text(
      txt,
      style: TextStyle(
        fontSize: 16.0,
        letterSpacing: 2.0,
      ),
    ),
    minWidth: 210.0,
    height: 50.0,
    color: type ?Colors.transparent : customColors.app_light_a,
    textColor: type ? customColors.app_light_a : customColors.app_black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(
        color: customColors.app_light_a,
        width: 1.0
      )
    ),
  );
}