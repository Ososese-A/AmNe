import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

AppBar main_app_bar (BuildContext ctx, VoidCallback refresh) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: customColors.app_black,
    title: 
    GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        height: 24.0,
        width: 80.0,
        child:  Row(
          children: [
            svg_box(22.0, 80.0, "assets/images/wordmark_a.svg")
          ],
        )
      ),
    ),
     
    

    actions: [
      GestureDetector(
        onTap: refresh,
        child: svg_box(24.0, 24.0, "assets/icons/refresh.svg")
      ),
      SizedBox(width: 20.0,)
    ],
  );
}