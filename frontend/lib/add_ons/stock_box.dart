import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Container stock_box ({
    String name = "Stock Name", 
    String symbol = "SYMB", 
    String price = "0.00 ETN",
    String percent = "0.00%",
    String change = "0.00 ETN", 
    bool positive = false,
    Color backgroundColor = const Color(0xff1C2541),
  }) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16.0)
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
    height: 160.0,
    width: 188.0,
    child: GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 160.0,
                height: 54.0,
                child: 
                  Text(
                    name, 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: customColors.app_white, fontSize: 16.0),)
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(symbol, style: TextStyle(color: customColors.app_white, fontSize: 14.0),),
              Text("$price ETN", style: TextStyle(color: customColors.app_white, fontSize: 12.0),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                positive
                ?
                "+$percent%"
                :
                "$percent%"
                , 
                style: TextStyle(
                  color: positive 
                  ? 
                  customColors.app_green 
                  : 
                  customColors.app_red, 
                  fontSize: 12.0
                ),
              ),
      
      
      
              Text(
                positive 
                ?
                "+$change ETN"
                :
                "$change ETN"
                , 
                style: TextStyle(
                  color: positive 
                  ? 
                  customColors.app_green 
                  : 
                  customColors.app_red, 
                  fontSize: 12.0
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}