import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

Future<void> toast_simulate (BuildContext context, txt) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss dialog
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Temporary Popup'),
        backgroundColor: customColors.app_dark_a,
        content: Container(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0, 
              color:  customColors.app_white
            ),
          ),
        )
      );
    },
  );

  // Close the dialog after 3 seconds
  await Future.delayed(Duration(seconds: 2));
  Navigator.of(context).pop();
}