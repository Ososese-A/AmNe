import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';
import 'package:intl/intl.dart';

Container transaction_record (String currency, amount, participant, time) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 40.0, left: 4.0, right: 4.0),
    decoration: BoxDecoration(
      color: double.parse(amount) > 0 ? customColors.app_dark_a : customColors.app_dark_b,
      borderRadius: BorderRadius.circular(8.0)
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currency, 
          style: TextStyle(color: customColors.app_white, fontSize: 32.0)
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140.0,
              child: Text(
                participant,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: customColors.app_white, fontSize: 16.0)
              ),
            ),
            Text(
              time,
              style: TextStyle(color: customColors.app_white, fontSize: 12.0)
            ),
          ],
        ),

        Text(
          '${NumberFormat('#,##0.00').format(double.parse(amount))} $currency',
          style: 
          double.parse(amount) > 0 
          ?
          TextStyle(color: customColors.app_green, fontSize: 12.0)
          :
          TextStyle(color: customColors.app_red, fontSize: 12.0)
        )
      ],
    ),
  );
}