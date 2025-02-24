import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Container pin_dot (bool active) {
  return Container(
    height: 20.0,
    width: 20.0,
    decoration: BoxDecoration(
      color: active ? customColors.app_light_a : customColors.app_black,
      borderRadius: BorderRadius.circular(360.0),
      border: Border.all(
        color: active ? customColors.app_light_a : customColors.app_light_b
      )
    ),
  );
}