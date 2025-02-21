import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

Container svg_box (double h, double w, String asset) {
  return Container(
            height: h,
            width: w,
            child: Image(
              image: Svg(
                asset
              )
            ),
          );
}