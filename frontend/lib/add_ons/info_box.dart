import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

GestureDetector info_box (txt) {
  return GestureDetector(
    child: Container(
      height: 80.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color:  customColors.app_dark_a,
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: TextStyle(
              color: customColors.app_white,
              fontSize: 20.0
            ),
          ),

          svg_box(16.0, 8.0, "assets/icons/front_arrow.svg")
        ],
      ),
    ),
  );
}