import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Container loading_spinner () {
  return Container(
    color: customColors.app_dark_transparency,
    child: Center(
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: CircularProgressIndicator(
          color: customColors.app_light_a,
          strokeWidth: 8.0,
          strokeCap: StrokeCap.round,
          trackGap: 100.0,
        ),
      ),
    ),
  );
}