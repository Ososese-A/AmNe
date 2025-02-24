import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

AppBar alt_app_bar (String page) {
  return AppBar(
    backgroundColor: customColors.app_black,
    title: Center(
      child: Text(
        page,
        style: TextStyle(
          color: customColors.app_white,
          fontSize: 32.0
        ),
      ),
    ),
  );
}