import 'package:flutter/widgets.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

GestureDetector key_btn (String number, bool type, String icon, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 100.0,
      width: 96.0,
      // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360.0),
        border: Border.all(
          color: customColors.app_white,
          width: 1.0
        ),
        color: customColors.app_black
      ),
      child: Center(
        child: type 
        ?
        svg_box(32.0, 32.0, icon != "" ? icon : "")
        :
        Text(
          number,
          style: TextStyle(
            color: customColors.app_white,
            fontSize: 40.0
          ),
        ),
      ),
    ),
  );
}