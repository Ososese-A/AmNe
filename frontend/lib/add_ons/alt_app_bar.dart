import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

AppBar alt_app_bar ({required String page, isLoading=false}) {
  return AppBar(
    backgroundColor: isLoading ? customColors.app_dark_transparency : customColors.app_black,
    automaticallyImplyLeading: false,
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