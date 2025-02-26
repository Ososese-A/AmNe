import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/components/currency_badge.dart';
import 'package:frontend/themes/theme.dart';

AppBar sec_app_bar (BuildContext ctx, String page) {
  return AppBar(
    backgroundColor: customColors.app_black,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(ctx);
      }, 
      icon: svg_box(44.0, 24.0, "assets/icons/back_arrow.svg")
    ),
    title: Text(
      page,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        color: customColors.app_white
      ),
    ),

    actions: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: CurrencyBadge(text: 'NGN')
      )
    ],
  );
}