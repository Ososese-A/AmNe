import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Container pin_dot ({required bool active, double height = 20.0, double width = 20.0, dotColor = false}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: dotColor ? customColors.app_white : (active ? customColors.app_light_a : customColors.app_black),
      borderRadius: BorderRadius.circular(360.0),
      border: Border.all(
        color: dotColor ? customColors.app_white : (active ? customColors.app_light_a : customColors.app_light_b)
      )
    ),
  );
}