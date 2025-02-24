import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

Container empty_msg (String imgPath, String msg) {
  return Container(
    width: 370.0,
    child: Column(
      children: [
        svg_box(240.0, 320.0, imgPath),
        SizedBox(height: 32.0,),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: customColors.app_white
          ),
        )
      ],
    ),
  );
}