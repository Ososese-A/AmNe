import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

GestureDetector borderless_btn (txt, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      child: Row(
        children: [
          Text(
            txt,
            style: TextStyle(
              color: customColors.app_light_a,
              fontSize: 16.0
            ),
          ),

          SizedBox(width: 16.0,),

          svg_box(16.0, 8.0, "assets/icons/front_arrow.svg")
        ],
      ),
    ),
  );
}